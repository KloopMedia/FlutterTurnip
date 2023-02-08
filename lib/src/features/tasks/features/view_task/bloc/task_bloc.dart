import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
// import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

part 'task_event.dart';
part 'task_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GigaTurnipRepository gigaTurnipRepository;
  final AuthUser user;
  final Campaign campaign;
  Timer? timer;
  TaskState? _cache;
  firebase_storage.Reference? storage;

  TaskBloc({
    required this.gigaTurnipRepository,
    required this.user,
    required this.campaign,
    required Task selectedTask,
    this.storage,
  }) : super(TaskState.fromTask(selectedTask, TaskStatus.initialized)) {
    timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (_cache != state && !state.complete) {
        _cache = state;
        _saveTask(state);
      }
    });
    on<InitializeTaskEvent>(_onInitializeTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<SubmitTaskEvent>(_onSubmitTask);
    on<ExitTaskEvent>(_onExitTask);
    on<GetDynamicSchemaTaskEvent>(_onGetDynamicSchema);
    on<GenerateIntegratedForm>(_onGenerateIntegratedForm);
    on<TriggerWebhook>(_onTriggerWebhook);
    on<UpdateIntegratedTask>(_onUpdateIntegratedTask,
        transformer: debounce(const Duration(milliseconds: 300)));
    final dynamicJsonMetadata = state.stage.dynamicJsonsTarget;
    if (dynamicJsonMetadata != null && dynamicJsonMetadata.isNotEmpty) {
      add(GetDynamicSchemaTaskEvent(state.responses ?? {}));
    }
    storage = firebase_storage.FirebaseStorage.instance.ref('${state.stage.chain.campaign}/'
        '${state.stage.chain.id}/'
        '${state.stage.id}/'
        '${user.id}/'
        '${state.id}');
  }

  Future<Map<String, dynamic>> getDynamicJson(
      int id, int taskId, Map<String, dynamic>? data) async {
    return await gigaTurnipRepository.getDynamicJsonTaskStage(id, taskId, data);
  }

  Future<List<Task>> getIntegratedTasks(int id) async {
    return await gigaTurnipRepository.getIntegratedTasks(id);
  }

  Future<Task> _getTask(int id) async {
    return await gigaTurnipRepository.getTask(id);
  }

  Future<int?> _saveTask(Task task) async {
    // final box = Hive.box<Task>(campaign.name);
    // box.put(task.id, task);
    return await gigaTurnipRepository.updateTask(task);
  }

  Future<List<Task>> _getPreviousTasks(int id) async {
    return gigaTurnipRepository.getPreviousTasks(id);
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    emit(state.copyWith(responses: event.formData));
  }

  void _onSubmitTask(SubmitTaskEvent event, Emitter<TaskState> emit) async {
    final newState = state.copyWith(responses: event.formData, complete: true);
    emit(newState);
    print('submit');
    final nextTaskId = await _saveTask(newState);
    if (nextTaskId != null) {
      final nextTask = await _getTask(nextTaskId);
      emit(newState.copyWith(taskStatus: TaskStatus.redirectToNextTask, nextTask: nextTask));
    } else {
      emit(newState.copyWith(taskStatus: TaskStatus.redirectToTasksList));
    }
  }

  void _onExitTask(ExitTaskEvent event, Emitter<TaskState> emit) async {
    if (!state.complete) {
      await _saveTask(state);
    }
    emit(state.copyWith(taskStatus: TaskStatus.redirectToTasksList));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  Future<void> _onInitializeTask(InitializeTaskEvent event, Emitter<TaskState> emit) async {
    final previousTasks = await _getPreviousTasks(state.id);
    final List<Task> integratedTasks = state.isIntegrated ? await getIntegratedTasks(state.id) : [];

    emit(state.copyWith(previousTasks: previousTasks, integratedTasks: integratedTasks));
  }

  String createStoragePathFromTask(Task task) {
    return '${task.stage.chain.campaign}/'
        '${task.stage.chain.id}/'
        '${task.stage.id}/'
        '${user.id}/'
        '${task.id}';
  }

  Future<void> _onGetDynamicSchema(GetDynamicSchemaTaskEvent event, Emitter<TaskState> emit) async {
    if (!state.complete) {
      emit(state.copyWith(taskStatus: TaskStatus.uninitialized));
      final schema = await getDynamicJson(state.stage.id, state.id, event.response);
      emit(state.copyWith(schema: schema, taskStatus: TaskStatus.initialized));
    }
  }

  void _onGenerateIntegratedForm(GenerateIntegratedForm event, Emitter<TaskState> emit) async {
    await gigaTurnipRepository.triggerWebhook(state.id);
    final task = await _getTask(state.id);
    emit(state.copyWith(responses: task.responses, taskStatus: TaskStatus.triggerWebhook));
    emit(state.copyWith(responses: task.responses, taskStatus: TaskStatus.initialized));
  }

  void _onUpdateIntegratedTask(UpdateIntegratedTask event, Emitter<TaskState> emit) {
    _saveTask(event.task);
  }

  void _onTriggerWebhook(TriggerWebhook event, Emitter<TaskState> emit) async {
    emit(state.copyWith(taskStatus: TaskStatus.uninitialized));

    try {
      final webhook = await gigaTurnipRepository.triggerWebhook(state.id);
      emit(state.copyWith(
        taskStatus: TaskStatus.triggerWebhook,
        responses: webhook['responses'],
      ));
      emit(state.copyWith(taskStatus: TaskStatus.initialized));
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(taskStatus: TaskStatus.initialized));
    }
  }
}
