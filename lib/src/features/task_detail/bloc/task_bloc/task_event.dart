part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class FetchTask extends TaskEvent {}

class UpdateTask extends TaskEvent {
  final Map<String, dynamic> formData;

  const UpdateTask(this.formData);
}

class SubmitTask extends TaskEvent {
  final Map<String, dynamic> formData;

  const SubmitTask(this.formData);
}

class TriggerWebhook extends TaskEvent {}
