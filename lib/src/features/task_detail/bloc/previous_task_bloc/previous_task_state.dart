part of 'previous_task_bloc.dart';


abstract class PreviousTaskState extends Equatable {
  const PreviousTaskState();

  @override
  List<Object> get props => [];
}

class PreviousTaskUninitialized extends PreviousTaskState {}

class PreviousTaskFetching extends PreviousTaskState {}

class PreviousTaskFetchingError extends PreviousTaskState {
  final String error;

  const PreviousTaskFetchingError(this.error);

  @override
  List<Object> get props => [error];
}

abstract class PreviousTaskInitialized extends PreviousTaskState {
  final List<Task> data;

  const PreviousTaskInitialized(this.data);

  PreviousTaskInitialized.clone(PreviousTaskInitialized state) : this(state.data);

  @override
  List<Object> get props => [data];
}

class PreviousTaskLoaded extends PreviousTaskInitialized {
  const PreviousTaskLoaded(super.data);
}
