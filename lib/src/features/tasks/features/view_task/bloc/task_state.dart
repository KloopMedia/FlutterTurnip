part of 'task_bloc.dart';

@immutable
class TaskState extends Task with EquatableMixin {
  TaskState({
    required int id,
    required String name,
    required Map<String, dynamic>? schema,
    required Map<String, dynamic>? uiSchema,
    required Map<String, dynamic>? responses,
    required bool complete,
    required bool reopened,
    required TaskStage stage,
    required DateTime? createdAt,})
      : super(
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

  factory TaskState.fromTask(Task task) {
    return TaskState(
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
    bool? complete,}) {
    return TaskState(
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
