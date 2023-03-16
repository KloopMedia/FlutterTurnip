part of 'creatable_task_cubit.dart';

class TaskCreating extends RemoteDataInitialized<TaskStage> {
  final int createdTaskId;

  TaskCreating({
    required this.createdTaskId,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  TaskCreating.clone(RemoteDataInitialized<TaskStage> state, this.createdTaskId)
      : super.clone(state);

  @override
  List<Object> get props => [...super.props, createdTaskId];
}

class TaskCreatingError extends RemoteDataInitialized<TaskStage> {
  final String error;

  TaskCreatingError({
    required this.error,
    required super.data,
    required super.currentPage,
    required super.total,
  });

  TaskCreatingError.clone(RemoteDataInitialized<TaskStage> state, this.error) : super.clone(state);

  @override
  List<Object> get props => [...super.props, error];
}
