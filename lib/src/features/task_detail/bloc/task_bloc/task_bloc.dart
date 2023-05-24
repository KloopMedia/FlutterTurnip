import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/utilities/functions.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final int taskId;
  final TaskDetailRepository _repository;
  final IndividualChainRepository chainRepository;

  TaskBloc({
    required TaskDetailRepository repository,
    required this.chainRepository,
    required this.taskId,
    Task? task,
  })  : _repository = repository,
        super(TaskUninitialized()) {
    on<InitializeTask>(_onInitializeTask);
    on<UpdateTask>(_onUpdateTask, transformer: debounce(const Duration(seconds: 2)));
    on<SubmitTask>(_onSubmitTask);
    on<TriggerWebhook>(_onTriggerWebhook);
    on<OpenTaskInfo>(_onOpenTaskInfo);
    on<CloseTaskInfo>(_onCloseTaskInfo);
  }

  Future<void> _onInitializeTask(InitializeTask event, Emitter<TaskState> emit) async {
    if (state is TaskUninitialized) {
      emit(TaskFetching());
      try {
        final data = await _repository.fetchData(taskId);
        final previousTasks = await _repository.fetchPreviousTaskData(taskId);
        final chainsData = chainRepository.fetchData();
        final parsedChains = chainsData.then((value) => value.results.map(Chain.fromApiModel).toList());
        final chains = await parsedChains;
        print('>>> chains = $chains');
        final chain = chains.where((element) => element.id == data.stage.chain);
        final isIndividual = chain.first.id == data.stage.chain;
        print('>>> isIndividual = $isIndividual');
        emit(TaskLoaded(data, previousTasks, isIndividual));
      } catch (e) {
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
      emit(TaskLoaded(updatedTask, _state.previousTasks, _state.isIndividual));
    }
  }

  Future<void> _onSubmitTask(SubmitTask event, Emitter<TaskState> emit) async {
    final _state = state as TaskInitialized;
    final formData = event.formData;

    try {
      final data = {'responses': formData, 'complete': true};
      final response = await _repository.saveData(taskId, data);
      final nextTaskId = response.nextDirectId;

      final updatedTask = _state.data.copyWith(responses: formData, complete: true);
      emit(TaskSubmitted(updatedTask, _state.previousTasks, _state.isIndividual, nextTaskId: nextTaskId));
    } catch (e) {
      print(e);
      emit(TaskSubmitError.clone(state as TaskLoaded, e.toString()));
    }
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
        emit(TaskLoaded(task, _state.previousTasks, _state.isIndividual));
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
}
