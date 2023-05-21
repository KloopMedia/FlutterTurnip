part of 'task_stage_chain_cubit.dart';

class TaskChainCreated extends RemoteDataInitialized<TaskStage> {
  final int createdTaskId;
  final int taskStageId;

  TaskChainCreated.clone(
      RemoteDataInitialized<TaskStage> state,
      this.createdTaskId,
      this.taskStageId,
  ) : super.clone(state);

  @override
  List<Object?> get props => [...super.props, createdTaskId, taskStageId];
}

class TaskChainCreatingError extends RemoteDataInitialized<TaskStage> {
  final String error;

  TaskChainCreatingError.clone(RemoteDataInitialized<TaskStage> state, this.error) : super.clone(state);

  @override
  List<Object?> get props => [...super.props, error];
}