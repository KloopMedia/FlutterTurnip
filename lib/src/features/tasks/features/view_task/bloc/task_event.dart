part of 'task_bloc.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class InitializeTaskEvent extends TaskEvent {}

class UpdateTaskEvent extends TaskEvent {
  final Map<String, dynamic> formData;

  UpdateTaskEvent(this.formData);
}

class SubmitTaskEvent extends TaskEvent {
  final Map<String, dynamic> formData;

  SubmitTaskEvent(this.formData);
}

class ExitTaskEvent extends TaskEvent {}
