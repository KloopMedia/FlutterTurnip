import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_repository/src/models/task_stage_detail.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

part 'task_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskDetail extends Equatable {
  final int id;
  final String name;
  final Map<String, dynamic>? schema;
  final Map<String, dynamic>? uiSchema;
  final Map<String, dynamic>? responses;
  final bool complete;
  final bool reopened;
  final TaskStageDetail stage;
  final DateTime? createdAt;
  final Map<String, dynamic>? cardJsonSchema;
  final Map<String, dynamic>? cardUiSchema;
  final List<int>? displayedPrevTasks;
  final bool isIntegrated;
  final List<Map<String, dynamic>>? dynamicSource;
  final List<Map<String, dynamic>>? dynamicTarget;
  final DateTime? startPeriod;
  final DateTime? endPeriod;

  const TaskDetail({
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
    required this.startPeriod,
    required this.endPeriod,
  });

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return _$TaskDetailFromJson(json);
  }

  factory TaskDetail.fromApiModel(api.TaskDetail model) {
    return TaskDetail(
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
      stage: TaskStageDetail.fromApiModel(model.stage),
      displayedPrevTasks: model.displayedPrevTasks,
      isIntegrated: model.integratorGroup != null,
      dynamicSource: model.stage.dynamicJsonsSource,
      dynamicTarget: model.stage.dynamicJsonsTarget,
      startPeriod: model.startPeriod,
      endPeriod: model.endPeriod,
    );
  }

  Map<String, dynamic> toJson() => _$TaskDetailToJson(this);

  TaskDetail copyWith(
      {Map<String, dynamic>? responses, bool? complete, Map<String, dynamic>? schema}) {
    return TaskDetail(
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
      startPeriod: startPeriod,
      endPeriod: endPeriod,
    );
  }

  @override
  List<Object?> get props => [id, responses, complete, reopened, stage];

  bool get isDynamic => dynamicTarget != null && (dynamicTarget?.isNotEmpty ?? false);
}
