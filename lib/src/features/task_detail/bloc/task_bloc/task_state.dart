part of 'task_bloc.dart';

mixin TaskErrorState on TaskState {
  late final String error;
}

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskUninitialized extends TaskState {}

class TaskFetching extends TaskState {}

class TaskFetchingError extends TaskState with TaskErrorState {
  TaskFetchingError(String error) {
    this.error = error;
  }

  @override
  List<Object> get props => [error];
}

abstract class TaskInitialized extends TaskState {
  final TaskDetail data;
  final List<TaskDetail> previousTasks;

  const TaskInitialized(this.data, this.previousTasks);

  TaskInitialized.clone(TaskInitialized state) : this(state.data, state.previousTasks);

  @override
  List<Object> get props => [data];
}

class TaskLoaded extends TaskInitialized {
  const TaskLoaded(super.data, super.previousTasks);

  TaskLoaded.clone(TaskInitialized state) : super.clone(state);
}

class TaskSubmitted extends TaskInitialized {
  final int? nextTaskId;

  const TaskSubmitted(super.data, super.previousTasks, {this.nextTaskId});
}

class TaskSubmitError extends TaskInitialized with TaskErrorState {
  TaskSubmitError(super.data, super.previousTasks, String error) {
    this.error = error;
  }

  TaskSubmitError.clone(TaskInitialized state, String error) : super.clone(state) {
    this.error = error;
  }
}

class RedirectToSms extends TaskInitialized {
  final String? phoneNumber;

  const RedirectToSms(super.data, super.previousTasks, this.phoneNumber);

  RedirectToSms.clone(TaskInitialized state, this.phoneNumber) : super.clone(state);
}

class TaskWebhookTriggered extends TaskInitialized {
  const TaskWebhookTriggered(super.data, super.previousTasks);
}

class TaskWebhookTriggerError extends TaskInitialized with TaskErrorState {
  TaskWebhookTriggerError(super.data, super.previousTasks, String error) {
    this.error = error;
  }

  TaskWebhookTriggerError.clone(TaskInitialized state, String error) : super.clone(state) {
    this.error = error;
  }
}

class TaskInfoOpened extends TaskInitialized {
  const TaskInfoOpened(super.data, super.previousTasks);

  TaskInfoOpened.clone(TaskInitialized state) : super.clone(state);
}

class TaskClosed extends TaskState {}

class TaskReleased extends TaskInitialized {
  const TaskReleased(super.data, super.previousTasks);

  TaskReleased.clone(TaskInitialized state) : super.clone(state);
}

class GoBackToPreviousTaskState extends TaskInitialized {
  final int previousTaskId;

  const GoBackToPreviousTaskState(super.data, super.previousTasks, this.previousTaskId);

  GoBackToPreviousTaskState.clone(TaskInitialized state, this.previousTaskId) : super.clone(state);
}

class GoBackToPreviousTaskError extends TaskInitialized with TaskErrorState {
  GoBackToPreviousTaskError(super.data, super.previousTasks, String error) {
    this.error = error;
  }

  GoBackToPreviousTaskError.clone(TaskInitialized state, String error) : super.clone(state) {
    this.error = error;
  }
}

class TaskReturned extends TaskInitialized {
  const TaskReturned(super.data, super.previousTasks);

  TaskReturned.clone(TaskInitialized state) : super.clone(state);
}

class FileDownloaded extends TaskInitialized {
  final String message;

  const FileDownloaded(super.data, super.previousTasks, this.message);

  FileDownloaded.clone(TaskInitialized state, this.message) : super.clone(state);
}
