import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Task;

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class Task extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final Map<String, dynamic>? schema;
  @HiveField(3)
  final Map<String, dynamic>? uiSchema;
  @HiveField(4)
  final Map<String, dynamic>? responses;
  @HiveField(5)
  final bool complete;
  @HiveField(6)
  final bool reopened;
  @HiveField(7)
  final TaskStage stage;
  @HiveField(8)
  final DateTime? createdAt;
  @HiveField(9)
  final Map<String, dynamic>? cardJsonSchema;
  @HiveField(10)
  final Map<String, dynamic>? cardUiSchema;
  @HiveField(11)
  final List<Task> displayedPrevTasks;
  @HiveField(12)
  final bool isIntegrated;
  @HiveField(13)
  final List<Map<String, dynamic>>? dynamicSource;
  @HiveField(14)
  final List<Map<String, dynamic>>? dynamicTarget;
  @HiveField(15)

  const Task({
    required this.id,
    required this.name,
    required this.responses,
    required this.complete,
    required this.reopened,
    required this.stage,
    required this.createdAt,
    required this.schema,
    required this.uiSchema,
    required this.cardJsonSchema,
    required this.cardUiSchema,
    required this.displayedPrevTasks,
    required this.isIntegrated,
    required this.dynamicSource,
    required this.dynamicTarget,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }

  factory Task.fromApiModel(api.Task model) {
    return Task(
      id: model.id,
      name: model.stage.name,
      responses: model.responses,
      complete: model.complete,
      reopened: model.reopened ?? false,
      createdAt: model.createdAt,
      schema: model.stage.jsonSchema,
      uiSchema: model.stage.uiSchema,
      cardJsonSchema: model.stage.cardJsonSchema,
      cardUiSchema: model.stage.cardUiSchema,
      stage: TaskStage.fromApiModel(model.stage),
      displayedPrevTasks:
          model.displayedPrevTasks?.map((task) => Task.fromApiModel(task)).toList() ?? [],
      isIntegrated: model.integratorGroup != null,
      dynamicSource: model.stage.dynamicJsonsSource,
      dynamicTarget: model.stage.dynamicJsonsTarget,
    );
  }

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({Map<String, dynamic>? responses, bool? complete, Map<String, dynamic>? schema}) {
    return Task(
      id: id,
      name: name,
      reopened: reopened,
      createdAt: createdAt,
      stage: stage,
      schema: schema ?? this.schema,
      uiSchema: uiSchema,
      cardJsonSchema: cardJsonSchema,
      cardUiSchema: cardUiSchema,
      displayedPrevTasks: displayedPrevTasks,
      isIntegrated: isIntegrated,
      responses: responses ?? this.responses,
      complete: complete ?? this.complete,
      dynamicSource: dynamicSource,
      dynamicTarget: dynamicTarget,
    );
  }

  @override
  List<Object?> get props => [id, responses, complete, reopened, stage];

  bool get isDynamic => dynamicTarget != null && (dynamicTarget?.isNotEmpty ?? false);
}
