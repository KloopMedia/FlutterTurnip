import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show TaskStage;

part 'task_stage.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskStage extends Equatable {
  final int id;
  final String name;
  final String description;
  final Chain chain;
  final String? richText;
  final Map<String, dynamic>? cardJsonSchema;
  final Map<String, dynamic>? cardUiSchema;
  final Map<String, dynamic>? jsonSchema;
  final Map<String, dynamic>? uiSchema;
  final List<Map<String, dynamic>> dynamicJsons;

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
    required this.dynamicJsons,
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
      dynamicJsons: model.dynamicJsons,
    );
  }

  Map<String, dynamic> toJson() => _$TaskStageToJson(this);

  @override
  List<Object?> get props => [id, name, description, chain, richText];
}
