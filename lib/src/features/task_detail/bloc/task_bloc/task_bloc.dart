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

  TaskBloc({
    required TaskDetailRepository repository,
    required this.taskId,
    Task? task,
  })  : _repository = repository,
        super(task != null ? TaskLoaded(task) : TaskUninitialized()) {
    on<FetchTask>(_onFetchTask);
    on<UpdateTask>(_onUpdateTask, transformer: debounce(const Duration(seconds: 1)));
    on<SubmitTask>(_onSubmitTask);
    on<TriggerWebhook>(_onTriggerWebhook);
    if (state is TaskUninitialized) {
      add(FetchTask());
    }
  }

  Future<void> _onFetchTask(FetchTask event, Emitter<TaskState> emit) async {
    emit(TaskFetching());
    try {
      final data = await _repository.fetchData(taskId);
      emit(TaskLoaded(data));
    } catch (e) {
      emit(TaskFetchingError(e.toString()));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    final task = (state as TaskInitialized).data;
    final formData = event.formData;

    final data = {'responses': formData};
    await _repository.saveData(taskId, data);

    if (task.isDynamic) {
      final newSchema = await _repository.getDynamicSchema(
        taskId: task.id,
        stageId: task.stage.id,
        data: data,
      );
      final updatedTask = task.copyWith(schema: newSchema);
      emit(TaskLoaded(updatedTask));
    }
  }

  Future<void> _onSubmitTask(SubmitTask event, Emitter<TaskState> emit) async {
    final task = (state as TaskInitialized).data;
    final formData = event.formData;

    emit(TaskFetching());
    try {
      final data = {'responses': formData, 'complete': true};
      final response = await _repository.saveData(taskId, data);
      final nextTaskId = response.nextDirectId;

      final updatedTask = task.copyWith(responses: formData, complete: true);
      emit(TaskSubmitted(updatedTask, nextTaskId: nextTaskId));
    } catch (e) {
      print(e);
      emit(TaskSubmitError.clone(state as TaskLoaded, e.toString()));
    }
  }

  Future<void> _onTriggerWebhook(TriggerWebhook event, Emitter<TaskState> emit) async {}
}
