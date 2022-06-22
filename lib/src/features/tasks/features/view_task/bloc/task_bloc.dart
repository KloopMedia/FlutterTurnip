import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GigaTurnipRepository gigaTurnipRepository;

  TaskBloc({
    required this.gigaTurnipRepository,
    required Task selectedTask,
  }) : super(TaskState(selectedTask)) {
    on<UpdateTaskEvent>(_onUpdateTask);
    on<SubmitTaskEvent>(_onSubmitTask);
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {}

  void _onSubmitTask(SubmitTaskEvent event, Emitter<TaskState> emit) {}
}
