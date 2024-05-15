import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_api/gigaturnip_api.dart' show BaseStageType;
import 'package:json_annotation/json_annotation.dart';

import '../../gigaturnip_repository.dart';

part 'task_stage_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskStageDetail extends BaseStage {
  final int campaign;
  final String? richText;
  final Map<String, dynamic>? cardJsonSchema;
  final Map<String, dynamic>? cardUiSchema;
  final Map<String, dynamic>? jsonSchema;
  final Map<String, dynamic>? uiSchema;
  final List<Map<String, dynamic>>? dynamicJsonsSource;
  final List<Map<String, dynamic>>? dynamicJsonsTarget;
  final bool allowRelease;
  final bool allowGoBack;
  final DateTime? availableTo;
  final DateTime? availableFrom;
  final int openLimit;
  final int totalLimit;
  final Map<String, dynamic>? quizAnswers;
  final String? externalRendererUrl;

  const TaskStageDetail({
    required super.id,
    required super.name,
    required super.description,
    required super.chain,
    required this.campaign,
    required this.richText,
    required this.cardJsonSchema,
    required this.cardUiSchema,
    required this.jsonSchema,
    required this.uiSchema,
    required this.dynamicJsonsSource,
    required this.dynamicJsonsTarget,
    required this.allowRelease,
    required this.allowGoBack,
    required this.availableTo,
    required this.availableFrom,
    required this.quizAnswers,
    required this.externalRendererUrl,
    this.openLimit = 0,
    this.totalLimit = 0,
    required super.inStages,
    required super.outStages,
    required super.xPos,
    required super.yPos,
    super.type = api.BaseStageType.task,
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
      dynamicJsonsTarget: model.dynamicJsonsTarget,
      allowRelease: model.allowRelease,
      allowGoBack: model.allowGoBack,
      availableTo: model.availableTo,
      availableFrom: model.availableFrom,
      quizAnswers: model.quizAnswers,
      openLimit: model.rankLimit?['open_limit'] ?? 0,
      totalLimit: model.rankLimit?['total_limit'] ?? 0,
      externalRendererUrl: model.externalRendererUrl,
      inStages: model.inStages,
      outStages: model.outStages,
      xPos: model.xPos,
      yPos: model.yPos,
      type: model.type,
    );
  }

  Map<String, dynamic> toJson() => _$TaskStageDetailToJson(this);

  @override
  List<Object?> get props => [id, name, description, chain, richText, availableFrom, availableTo];
}
