import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:json_annotation/json_annotation.dart';

part 'task_stage_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskStageDetail extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int chain;
  final int campaign;
  final String? richText;
  final Map<String, dynamic>? cardJsonSchema;
  final Map<String, dynamic>? cardUiSchema;
  final Map<String, dynamic>? jsonSchema;
  final Map<String, dynamic>? uiSchema;
  final List<Map<String, dynamic>>? dynamicJsonsSource;
  final List<Map<String, dynamic>>? dynamicJsonsTarget;

  const TaskStageDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
    required this.campaign,
    required this.richText,
    required this.cardJsonSchema,
    required this.cardUiSchema,
    required this.jsonSchema,
    required this.uiSchema,
    required this.dynamicJsonsSource,
    required this.dynamicJsonsTarget,
  });

  factory TaskStageDetail.fromJson(Map<String, dynamic> json) {
    return _$TaskStageDetailFromJson(json);
  }

  factory TaskStageDetail.fromApiModel(api.TaskStageDetail model) {
    return TaskStageDetail(
        id: model.id,
        name: model.name,
        description: model.description,
        chain: model.chain,
        campaign: model.campaign,
        richText: model.richText,
        cardJsonSchema: model.cardJsonSchema,
        cardUiSchema: model.cardUiSchema,
        jsonSchema: model.jsonSchema,
        uiSchema: model.uiSchema,
        dynamicJsonsSource: model.dynamicJsonsSource,
        dynamicJsonsTarget: model.dynamicJsonsTarget);
  }

  Map<String, dynamic> toJson() => _$TaskStageDetailToJson(this);

  @override
  List<Object?> get props => [id, name, description, chain, richText];
}
