import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show TaskStage;

part 'task_stage.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class TaskStage extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final Chain chain;
  @HiveField(4)
  final String? richText;
  @HiveField(5)
  final Map<String, dynamic>? cardJsonSchema;
  @HiveField(6)
  final Map<String, dynamic>? cardUiSchema;
  @HiveField(7)
  final Map<String, dynamic>? jsonSchema;
  @HiveField(8)
  final Map<String, dynamic>? uiSchema;
  @HiveField(9)
  final List<Map<String, dynamic>>? dynamicJsonsSource;
  @HiveField(10)
  final List<Map<String, dynamic>>? dynamicJsonsTarget;

  const TaskStage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
    required this.richText,
    required this.cardJsonSchema,
    required this.cardUiSchema,
    required this.jsonSchema,
    required this.uiSchema,
    required this.dynamicJsonsSource,
    required this.dynamicJsonsTarget,
  });

  factory TaskStage.fromJson(Map<String, dynamic> json) {
    return _$TaskStageFromJson(json);
  }

  factory TaskStage.fromApiModel(api.TaskStage model) {
    return TaskStage(
      id: model.id,
      name: model.name,
      description: model.description,
      chain: Chain.fromApiModel(model.chain),
      richText: model.richText,
      cardJsonSchema: model.cardJsonSchema,
      cardUiSchema: model.cardUiSchema,
      jsonSchema: model.jsonSchema,
      uiSchema: model.uiSchema,
      dynamicJsonsSource: model.dynamicJsonsSource,
      dynamicJsonsTarget: model.dynamicJsonsTarget
    );
  }

  Map<String, dynamic> toJson() => _$TaskStageToJson(this);

  @override
  List<Object?> get props => [id, name, description, chain, richText];
}
