import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final int id;
  final TaskDetailRepository _repository;

  TaskBloc({
    required TaskDetailRepository repository,
    required this.id,
    Task? task,
  })  : _repository = repository,
        super(task != null ? TaskLoaded(task) : TaskUninitialized()) {
    on<FetchTask>(_onFetchTask);
    on<UpdateTask>(_onUpdateTask);
    on<SubmitTask>(_onSubmitTask);
    on<TriggerWebhook>(_onTriggerWebhook);
    if (state is TaskUninitialized) {
      add(FetchTask());
    }
  }

  Future<void> _onFetchTask(FetchTask event, Emitter<TaskState> emit) async {
    emit(TaskFetching());
    try {
      final data = await _repository.fetchData(id);
      emit(TaskLoaded(data));
    } catch (e) {
      emit(TaskFetchingError(e.toString()));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {}

  Future<void> _onSubmitTask(SubmitTask event, Emitter<TaskState> emit) async {}

  Future<void> _onTriggerWebhook(TriggerWebhook event, Emitter<TaskState> emit) async {}
}
