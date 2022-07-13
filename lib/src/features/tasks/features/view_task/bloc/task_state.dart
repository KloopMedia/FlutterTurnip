part of 'task_bloc.dart';

enum TaskStatus {
  uninitialized,
  initialized,
  redirectToNextTask,
  redirectToTasksList,
}

@immutable
class TaskState extends Task with EquatableMixin {
  final Task? nextTask;
  final TaskStatus taskStatus;

  TaskState({
    this.nextTask,
    required this.taskStatus,
    required int id,
    required String name,
    required Map<String, dynamic>? schema,
    required Map<String, dynamic>? uiSchema,
    required Map<String, dynamic>? responses,
    required bool complete,
    required bool reopened,
    required TaskStage stage,
    required DateTime? createdAt,
  }) : super(
          id: id,
          name: name,
          responses: responses,
          complete: complete,
          reopened: reopened,
          stage: stage,
          createdAt: createdAt,
          schema: schema,
          uiSchema: uiSchema,
        );

  factory TaskState.fromTask(Task task, TaskStatus taskStatus) {
    return TaskState(
      taskStatus: taskStatus,
      id: task.id,
      name: task.name,
      responses: task.responses,
      complete: task.complete,
      reopened: task.reopened,
      stage: task.stage,
      createdAt: task.createdAt,
      schema: task.schema,
      uiSchema: task.uiSchema,
    );
  }

  @override
  List<Object?> get props => [id, responses, complete];

  TaskState copyWith({
    Map<String, dynamic>? responses,
    bool? complete,
    TaskStatus? taskStatus,
    Task? nextTask,
  }) {
    return TaskState(
      nextTask: nextTask ?? this.nextTask,
      taskStatus: taskStatus ?? this.taskStatus,
      responses: responses ?? this.responses,
      complete: complete ?? this.complete,
      createdAt: createdAt,
      name: name,
      schema: schema,
      id: id,
      reopened: reopened,
      stage: stage,
      uiSchema: uiSchema,
    );
  }
}
