import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GigaTurnipRepository gigaTurnipRepository;
  Timer? timer;
  TaskState? _cache;

  TaskBloc({
    required this.gigaTurnipRepository,
    required Task selectedTask,
  }) : super(TaskState.fromTask(selectedTask, TaskStatus.initialized)) {
    timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (_cache != state) {
        _cache = state;
        _saveTask(state);
      }
    });
    on<InitializeTaskEvent>(_onInitializeTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<SubmitTaskEvent>(_onSubmitTask);
    on<ExitTaskEvent>(_onExitTask);
  }

  Future<Task> _getTask(int id) async {
    return await gigaTurnipRepository.getTask(id);
  }

  Future<int?> _saveTask(Task task) async {
    if (!state.complete) {
      return await gigaTurnipRepository.updateTask(task);
    }
    return null;
  }

  Future<List<Task>> _getPreviousTasks(int id) async {
    return gigaTurnipRepository.getPreviousTasks(id);
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    emit(state.copyWith(responses: event.formData));
  }

  void _onSubmitTask(SubmitTaskEvent event, Emitter<TaskState> emit) async {
    final newState = state.copyWith(responses: event.formData, complete: true);
    final nextTaskId = await _saveTask(newState);
    if (nextTaskId != null) {
      final nextTask = await _getTask(nextTaskId);
      emit(newState.copyWith(taskStatus: TaskStatus.redirectToNextTask, nextTask: nextTask));
    } else {
      emit(newState.copyWith(taskStatus: TaskStatus.redirectToTasksList));
    }
  }

  void _onExitTask(ExitTaskEvent event, Emitter<TaskState> emit) {
    _saveTask(state);
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  Future<void> _onInitializeTask(InitializeTaskEvent event, Emitter<TaskState> emit) async {
    final previousTasks = await _getPreviousTasks(state.id);
    print("PREV TASKS $previousTasks");
    emit(state.copyWith(previousTasks: previousTasks));
  }
}
