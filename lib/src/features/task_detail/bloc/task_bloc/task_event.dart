part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class InitializeTask extends TaskEvent {}

class UpdateTask extends TaskEvent {
  final Map<String, dynamic> formData;

  const UpdateTask(this.formData);
}

class SubmitTask extends TaskEvent {
  final Map<String, dynamic>? formData;

  const SubmitTask(this.formData);
}

class TriggerWebhook extends TaskEvent {}

class CloseNotification extends TaskEvent {
  final TaskDetail data;
  final List<TaskDetail> previousTasks;
  final int? nextTaskId;

  const CloseNotification(this.previousTasks, this.data, this.nextTaskId);
}

class OpenTaskInfo extends TaskEvent {}

class CloseTaskInfo extends TaskEvent {}

class CloseTask extends TaskEvent {}

class RefetchTask extends TaskEvent {}

class ValidationFailed extends TaskEvent {
  final String error;

  const ValidationFailed(this.error);
}

class DownloadFile extends TaskEvent {
  final String message;

  const DownloadFile(this.message);
}

class ReleaseTask extends TaskEvent {}

class GoBackToPreviousTask extends TaskEvent {}
