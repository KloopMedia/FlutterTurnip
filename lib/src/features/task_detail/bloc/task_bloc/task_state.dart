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
  final bool isIndividual;

  const TaskInitialized(this.data, this.previousTasks, this.isIndividual);

  TaskInitialized.clone(TaskInitialized state) : this(state.data, state.previousTasks, state.isIndividual);

  @override
  List<Object> get props => [data];
}

class TaskLoaded extends TaskInitialized {
  const TaskLoaded(super.data, super.previousTasks, super.isIndividual);

  TaskLoaded.clone(TaskInitialized state) : super.clone(state);
}

class TaskSubmitted extends TaskInitialized {
  final int? nextTaskId;

  const TaskSubmitted(super.data, super.previousTasks, super.isIndividual, {this.nextTaskId});
}

class TaskSubmitError extends TaskInitialized {
  final String error;

  const TaskSubmitError(super.data, super.previousTasks, this.error, super.isIndividual);

  TaskSubmitError.clone(TaskInitialized state, this.error) : super.clone(state);
}

class TaskWebhookTriggered extends TaskInitialized {
  const TaskWebhookTriggered(super.data, super.previousTasks, super.isIndividual);
}

class TaskWebhookTriggerError extends TaskInitialized {
  final String error;

  const TaskWebhookTriggerError(super.data, super.previousTasks, this.error, super.isIndividual);

  TaskWebhookTriggerError.clone(TaskInitialized state, this.error) : super.clone(state);
}

class TaskInfoOpened extends TaskInitialized {
  const TaskInfoOpened(super.data, super.previousTasks, super.isIndividual);

  TaskInfoOpened.clone(TaskInitialized state) : super.clone(state);
}

class TaskClosed extends TaskState {}
