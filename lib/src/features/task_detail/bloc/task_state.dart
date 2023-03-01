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

  @override
  List<Object> get props => [data];
}

class TaskLoaded extends TaskInitialized {
  const TaskLoaded(super.data);
}

class TaskComplete extends TaskInitialized {
  const TaskComplete(super.data);
}

class TaskWebhookTriggered extends TaskInitialized {
  const TaskWebhookTriggered(super.data);
}
