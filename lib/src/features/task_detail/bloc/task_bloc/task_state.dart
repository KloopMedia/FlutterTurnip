part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskUninitialized extends TaskState {}

class TaskFetching extends TaskState {}

class TaskFetchingError extends TaskState {
  final String error;

  const TaskFetchingError(this.error);

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

class TaskSubmitError extends TaskInitialized {
  final String error;

  const TaskSubmitError(super.data, super.previousTasks, this.error);

  TaskSubmitError.clone(TaskInitialized state, this.error) : super.clone(state);
}

class TaskWebhookTriggered extends TaskInitialized {
  const TaskWebhookTriggered(super.data, super.previousTasks);
}

class TaskWebhookTriggerError extends TaskInitialized {
  final String error;

  const TaskWebhookTriggerError(super.data, super.previousTasks, this.error);

  TaskWebhookTriggerError.clone(TaskInitialized state, this.error) : super.clone(state);
}

class TaskInfoOpened extends TaskInitialized {
  const TaskInfoOpened(super.data, super.previousTasks);

  TaskInfoOpened.clone(TaskInitialized state) : super.clone(state);
}

class TaskClosed extends TaskState {}
