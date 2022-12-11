part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class InitializeTaskEvent extends TaskEvent {
  const InitializeTaskEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTaskEvent extends TaskEvent {
  final Map<String, dynamic> formData;
  final MapPath path;

  const UpdateTaskEvent({required this.formData, required this.path});

  @override
  List<Object?> get props => [formData, path];
}

class SubmitTaskEvent extends TaskEvent {
  final Map<String, dynamic> formData;

  const SubmitTaskEvent(this.formData);

  @override
  List<Object?> get props => [formData];
}

class ExitTaskEvent extends TaskEvent {
  const ExitTaskEvent();

  @override
  List<Object?> get props => [];
}
