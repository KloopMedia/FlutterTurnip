part of 'task_bloc.dart';

mixin TaskErrorState on TaskState {
  late final String error;
}

mixin TaskLoadingState on TaskState {}

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskUninitialized extends TaskState {}

class TaskFetching extends TaskState with TaskLoadingState {}

class TaskFetchingError extends TaskState with TaskErrorState {
  TaskFetchingError(String error) {
    this.error = "TASK_FETCHING_ERROR $error";
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

class TaskRefetching extends TaskInitialized with TaskLoadingState {
  const TaskRefetching(super.data, super.previousTasks);

  TaskRefetching.clone(TaskInitialized state) : super.clone(state);
}

class TaskLoaded extends TaskInitialized {
  const TaskLoaded(super.data, super.previousTasks);

  TaskLoaded.clone(TaskInitialized state) : super.clone(state);
}

class TaskSubmitted extends TaskInitialized {
  final int? nextTaskId;

  const TaskSubmitted(super.data, super.previousTasks, {this.nextTaskId});
}

class NotificationOpened extends TaskInitialized {
  final TaskDetail task;
  final List<TaskDetail> previousTask;
  final int? nextTaskId;
  final String text;

  const NotificationOpened(
    super.data,
    super.previousTasks, {
    required this.task,
    required this.previousTask,
    required this.text,
    this.nextTaskId
  });

  NotificationOpened.clone(TaskInitialized state, this.task, this.previousTask, this.nextTaskId, this.text) : super.clone(state);
}

class TaskSubmitError extends TaskInitialized with TaskErrorState {
  TaskSubmitError(super.data, super.previousTasks, String error) {
    this.error = "SUBMIT_ERROR $error";
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
    this.error = "WEBHOOK_TRIGGER_ERROR $error";
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
    this.error = "GO_BACK_TO_PREVIOUS_TASK_ERROR $error";
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

class ShowAnswers extends TaskInitialized {
  final int? nextTaskId;

  const ShowAnswers(super.data, super.previousTasks, this.nextTaskId);

  ShowAnswers.clone(TaskInitialized state, this.nextTaskId) : super.clone(state);
}
