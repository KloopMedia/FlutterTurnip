part of 'task_stage_chain_cubit.dart';

class TaskChainCreated extends RemoteDataInitialized<TaskStage> {
  final int createdTaskId;

  TaskChainCreated.clone(RemoteDataInitialized<TaskStage> state, this.createdTaskId)
      : super.clone(state);

  @override
  List<Object?> get props => [...super.props, createdTaskId];
}

class TaskChainCreatingError extends RemoteDataInitialized<TaskStage> {
  final String error;

  TaskChainCreatingError.clone(RemoteDataInitialized<TaskStage> state, this.error) : super.clone(state);

  @override
  List<Object?> get props => [...super.props, error];
}