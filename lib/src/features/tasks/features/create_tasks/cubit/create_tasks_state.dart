part of 'create_tasks_cubit.dart';

@immutable
class CreateTasksState extends Equatable {
  final List<TaskStage> taskStages;
  final TasksStatus status;
  final String? errorMessage;

  const CreateTasksState({
    this.taskStages = const [],
    this.status = TasksStatus.uninitialized,
    this.errorMessage,
  });

  CreateTasksState copyWith({
    List<TaskStage>? taskStages,
    TasksStatus? status,
    String? errorMessage,
  }) {
    return CreateTasksState(
      taskStages: taskStages ?? this.taskStages,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [taskStages, status];
}
