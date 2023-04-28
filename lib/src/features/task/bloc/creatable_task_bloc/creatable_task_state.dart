part of 'creatable_task_cubit.dart';

class TaskCreated extends RemoteDataInitialized<TaskStage> {
  final int createdTaskId;

  TaskCreated.clone(RemoteDataInitialized<TaskStage> state, this.createdTaskId)
      : super.clone(state);

  @override
  List<Object?> get props => [...super.props, createdTaskId];
}

class TaskCreatingError extends RemoteDataInitialized<TaskStage> {
  final String error;

  TaskCreatingError.clone(RemoteDataInitialized<TaskStage> state, this.error) : super.clone(state);

  @override
  List<Object?> get props => [...super.props, error];
}
