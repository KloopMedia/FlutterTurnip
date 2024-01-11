import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/utilities/functions.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final int taskId;
  final TaskDetailRepository _repository;
  final CampaignDetailRepository _campaignRepository;

  TaskBloc({
    required TaskDetailRepository repository,
    required CampaignDetailRepository campaignRepository,
    required this.taskId,
    Task? task,
  })  : _repository = repository,
        _campaignRepository = campaignRepository,
        super(TaskUninitialized()) {
    on<InitializeTask>(_onInitializeTask);
    on<UpdateTask>(_onUpdateTask, transformer: debounce(const Duration(seconds: 2)));
    on<SubmitTask>(_onSubmitTask);
    on<TriggerWebhook>(_onTriggerWebhook);
    on<OpenTaskInfo>(_onOpenTaskInfo);
    on<CloseTaskInfo>(_onCloseTaskInfo);
    on<RefetchTask>(_onRefetchTask);
    on<ValidationFailed>(_onValidationFailed);
    on<DownloadFile>(_onFileDownloaded);
    on<ReleaseTask>(_onReleaseTask);
    on<GoBackToPreviousTask>(_onGoBackToPreviousTask);
    on<CloseTask>(_onCloseTask);
    on<CloseNotification>(_onCloseNotification);
  }

  Future<void> _onInitializeTask(InitializeTask event, Emitter<TaskState> emit) async {
    if (state is TaskUninitialized) {
      emit(TaskFetching());
      try {
        final data = await _repository.fetchData(taskId);
        final previousTasks = await _repository.fetchPreviousTaskData(taskId);
        emit(TaskLoaded(data, previousTasks));
      } catch (e, t) {
        print("TASK FETCHING ERROR: ${e.toString()}");
        print(t.toString());
        emit(TaskFetchingError(e.toString()));
      }
    }
    final task = state;
    if (task is TaskInitialized && (task.data.stage.richText?.isNotEmpty ?? false)) {
      add(OpenTaskInfo());
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    final _state = state as TaskInitialized;
    final formData = event.formData;

    final data = {'responses': formData};
    await _repository.saveData(taskId, data);

    if (_state.data.isDynamic) {
      final newSchema = await _repository.getDynamicSchema(
        taskId: _state.data.id,
        stageId: _state.data.stage.id,
        data: data,
      );
      final updatedTask = _state.data.copyWith(schema: newSchema);
      emit(TaskLoaded(updatedTask, _state.previousTasks));
    }
  }

  Future<void> _onSubmitTask(SubmitTask event, Emitter<TaskState> emit) async {
    final _state = state as TaskInitialized;
    final formData = event.formData;

    final updatedTask = _state.data.copyWith(responses: formData, complete: true);
    TaskResponse response;
    try {
      emit(TaskRefetching.clone(_state));
      response = await _repository.submitTask(updatedTask);
    } on DioException catch (e) {
      print("SUBMIT NETWORK ERROR: $e");
      final campaign = await _campaignRepository.fetchData(_state.data.stage.campaign);
      if (campaign.smsCompleteTaskAllow &&
          (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.unknown)) {
        final updatedTask = _state.data.copyWith(responses: formData);
        emit(RedirectToSms.clone(_state, campaign.smsPhone));
        emit(TaskLoaded(updatedTask, _state.previousTasks));
      } else {
        final updatedTask = _state.data.copyWith(responses: formData, complete: true);
        emit(TaskSubmitted(updatedTask, _state.previousTasks, nextTaskId: null));
      }
      return;
    } catch (e) {
      print("SUBMIT ERROR: $e");
      final updatedTask = _state.data.copyWith(responses: formData);
      emit(TaskSubmitError(updatedTask, _state.previousTasks, e.toString()));
      emit(TaskLoaded(updatedTask, _state.previousTasks));
      return;
    }

    final nextTaskId = response.nextDirectId;
    final quizAnswers = _state.data.stage.quizAnswers;

    final notifications = response.notifications;
    if (notifications != null && notifications.isNotEmpty) {
      final text = notifications.first['text'];
      emit(
        NotificationOpened(
          updatedTask,
          _state.previousTasks,
          text: text,
          task: updatedTask,
          previousTask: _state.previousTasks,
          nextTaskId: nextTaskId,
        ),
      );
    }

    if (nextTaskId == taskId) {
      emit(TaskReturned.clone(_state));
    } else if (quizAnswers != null && quizAnswers.isNotEmpty) {
      emit(ShowAnswers(updatedTask, _state.previousTasks, nextTaskId));
    } else {
      emit(TaskSubmitted(updatedTask, _state.previousTasks, nextTaskId: nextTaskId));
    }
  }

  FutureOr<void> _onCloseNotification(CloseNotification event, Emitter<TaskState> emit) {
    emit(TaskSubmitted(event.data, event.previousTasks, nextTaskId: event.nextTaskId));
  }

  Future<void> _onTriggerWebhook(TriggerWebhook event, Emitter<TaskState> emit) async {
    final _state = state;
    if (_state is TaskInitialized && !_state.data.complete) {
      emit(TaskFetching());
      try {
        final data = {'responses': _state.data.responses};
        await _repository.saveData(taskId, data);
        final responses = await _repository.triggerWebhook(taskId);
        final task = _state.data.copyWith(responses: responses);
        emit(TaskLoaded(task, _state.previousTasks));
      } catch (e) {
        print(e);
        emit(TaskWebhookTriggerError.clone(_state, e.toString()));
      }
    }
  }

  Future<void> _onOpenTaskInfo(OpenTaskInfo event, Emitter<TaskState> emit) async {
    final _state = state;
    if (_state is TaskInitialized) {
      emit(TaskInfoOpened.clone(_state));
    }
  }

  Future<void> _onCloseTaskInfo(CloseTaskInfo event, Emitter<TaskState> emit) async {
    emit(TaskLoaded.clone(state as TaskInitialized));
    final task = (state as TaskInitialized).data;
    final isSchemaEmpty = task.schema?.isEmpty ?? true;
    if (!task.complete && isSchemaEmpty) {
      add(SubmitTask(task.responses));
    } else {
      if (isSchemaEmpty) {
        emit(TaskClosed());
      }
    }
  }

  Future<void> _onRefetchTask(RefetchTask event, Emitter<TaskState> emit) async {
    try {
      emit(TaskFetching());
      final data = await _repository.fetchData(taskId);
      final previousTasks = await _repository.fetchPreviousTaskData(taskId);
      emit(TaskLoaded(data, previousTasks));
    } catch (e) {
      emit(TaskFetchingError(e.toString()));
    }
  }

  Future<void> _onValidationFailed(ValidationFailed event, Emitter<TaskState> emit) async {
    final _state = state as TaskInitialized;
    final error = event.error;
    emit(TaskSubmitError.clone(_state, error));
    emit(TaskLoaded(_state.data, _state.previousTasks));
  }

  Future<void> _onFileDownloaded(DownloadFile event, Emitter<TaskState> emit) async {
    final _state = state as TaskInitialized;
    final error = event.message;
    emit(FileDownloaded.clone(_state, error));
    emit(TaskLoaded(_state.data, _state.previousTasks));
  }

  Future<void> _onReleaseTask(ReleaseTask event, Emitter<TaskState> emit) async {
    await _repository.releaseTask(taskId);
    emit(TaskReleased.clone(state as TaskInitialized));
  }

  Future<void> _onGoBackToPreviousTask(GoBackToPreviousTask event, Emitter<TaskState> emit) async {
    final _state = state as TaskInitialized;
    try {
      emit(TaskFetching());
      final previousTaskId = await _repository.openPreviousTask(taskId);
      emit(GoBackToPreviousTaskState.clone(_state, previousTaskId));
    } catch (e) {
      emit(GoBackToPreviousTaskError.clone(_state, e.toString()));
    }
  }

  Future<void> _onCloseTask(CloseTask event, Emitter<TaskState> emit) async {
    emit(TaskLoaded.clone(state as TaskInitialized));
    final task = (state as TaskInitialized).data;
    final isSchemaEmpty = task.schema?.isEmpty ?? true;
    if (isSchemaEmpty) {
      emit(TaskClosed());
    }
  }
}
