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
  final Task data;

  const TaskInitialized(this.data);

  TaskInitialized.clone(TaskInitialized state) : this(state.data);

  @override
  List<Object> get props => [data];
}

class TaskLoaded extends TaskInitialized {
  const TaskLoaded(super.data);
}

class TaskSubmitted extends TaskInitialized {
  final int? nextTaskId;

  const TaskSubmitted(super.data, {this.nextTaskId});
}

class TaskSubmitError extends TaskInitialized {
  final String error;

  const TaskSubmitError(super.data, this.error);

  TaskSubmitError.clone(TaskInitialized state, this.error) : super.clone(state);
}

class TaskWebhookTriggered extends TaskInitialized {
  const TaskWebhookTriggered(super.data);
}
