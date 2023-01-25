part of 'task_bloc.dart';

enum TaskStatus {
  uninitialized,
  initialized,
  redirectToNextTask,
  redirectToTasksList,
  triggerWebhook,
}

@immutable
class TaskState extends Task with EquatableMixin {
  final Task? nextTask;
  final List<Task> previousTasks;
  final TaskStatus taskStatus;
  final List<Task> integratedTasks;
  final bool isRichTextViewed;

  TaskState({
    this.nextTask,
    this.previousTasks = const [],
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
    required Map<String, dynamic>? cardJsonSchema,
    required Map<String, dynamic>? cardUiSchema,
    required List<Task> displayedPrevTasks,
    required bool isIntegrated,
    required List<Map<String, dynamic>>? dynamicSource,
    required List<Map<String, dynamic>>? dynamicTarget,
    this.integratedTasks = const [],
    this.isRichTextViewed = false,
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
          cardJsonSchema: cardJsonSchema,
          cardUiSchema: cardUiSchema,
          displayedPrevTasks: displayedPrevTasks,
          isIntegrated: isIntegrated,
          dynamicSource: dynamicSource,
          dynamicTarget: dynamicTarget,
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
      cardJsonSchema: task.cardJsonSchema,
      cardUiSchema: task.cardUiSchema,
      displayedPrevTasks: task.displayedPrevTasks,
      isIntegrated: task.isIntegrated,
      dynamicSource: task.dynamicSource,
      dynamicTarget: task.dynamicTarget,
    );
  }

  @override
  List<Object?> get props => [id, responses, complete, previousTasks, nextTask, taskStatus, schema, uiSchema];

  @override
  TaskState copyWith({
    Map<String, dynamic>? responses,
    bool? complete,
    TaskStatus? taskStatus,
    Task? nextTask,
    List<Task>? previousTasks,
    Map<String, dynamic>? schema,
    Map<String, dynamic>? uiSchema,
    List<Task>? integratedTasks,
    bool? isRichTextViewed,
  }) {
    return TaskState(
      previousTasks: previousTasks ?? this.previousTasks,
      nextTask: nextTask ?? this.nextTask,
      taskStatus: taskStatus ?? this.taskStatus,
      responses: responses ?? this.responses,
      complete: complete ?? this.complete,
      createdAt: createdAt,
      name: name,
      schema: schema ?? this.schema,
      id: id,
      reopened: reopened,
      stage: stage,
      uiSchema: uiSchema ?? this.uiSchema,
      cardJsonSchema: cardJsonSchema,
      cardUiSchema: cardUiSchema,
      displayedPrevTasks: displayedPrevTasks,
      isIntegrated: isIntegrated,
      dynamicSource: dynamicSource,
      dynamicTarget: dynamicTarget,
      integratedTasks: integratedTasks ?? this.integratedTasks,
      isRichTextViewed: isRichTextViewed ?? this.isRichTextViewed,
    );
  }
}
