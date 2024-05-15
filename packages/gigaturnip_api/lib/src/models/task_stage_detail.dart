import 'dart:convert';

import 'package:gigaturnip_api/src/models/base_stage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_stage_detail.g.dart';

@JsonSerializable()
class TaskStageDetail extends BaseStage {
  final int campaign;
  @JsonKey(fromJson: _stringToMap, toJson: _stringFromMap)
  final Map<String, dynamic> jsonSchema;
  @JsonKey(fromJson: _stringToMap, toJson: _stringFromMap)
  final Map<String, dynamic> uiSchema;
  final bool isCreatable;
  final String? richText;
  final List<Map<String, dynamic>>? dynamicJsonsSource;
  final List<Map<String, dynamic>>? dynamicJsonsTarget;
  final String? webhookResponseField;
  final bool allowGoBack;
  final bool allowRelease;
  final Map<String, dynamic>? externalMetadata;
  @JsonKey(fromJson: _stringToMap, toJson: _stringFromMap)
  final Map<String, dynamic> cardJsonSchema;
  @JsonKey(fromJson: _stringToMap, toJson: _stringFromMap)
  final Map<String, dynamic> cardUiSchema;
  final DateTime? availableTo;
  final DateTime? availableFrom;
  final List<Map<String, dynamic>>? filterFieldsSchema;
  final Map<String, dynamic>? rankLimit;
  final Map<String, dynamic>? quizAnswers;
  final String? externalRendererUrl;

  TaskStageDetail({
    required super.id,
    required super.name,
    required super.description,
    required super.chain,
    required super.xPos,
    required super.yPos,
    required this.campaign,
    required this.jsonSchema,
    required this.uiSchema,
    required this.isCreatable,
    required this.richText,
    required this.dynamicJsonsSource,
    required this.dynamicJsonsTarget,
    required this.webhookResponseField,
    required this.allowGoBack,
    required this.allowRelease,
    required this.externalMetadata,
    required this.cardJsonSchema,
    required this.cardUiSchema,
    required this.availableTo,
    required this.availableFrom,
    required this.filterFieldsSchema,
    required this.quizAnswers,
    this.rankLimit,
    required this.externalRendererUrl,
    required super.inStages,
    required super.outStages,
    super.type = BaseStageType.task,
  });

  factory TaskStageDetail.fromJson(Map<String, dynamic> json) {
    return _$TaskStageDetailFromJson(json);
  }

  static Map<String, dynamic> _stringToMap(String? json) {
    try {
      return json != null ? jsonDecode(json) : {};
    } catch (e) {
      return {};
    }
  }

  static String _stringFromMap(Map<String, dynamic> json) => jsonEncode(json);
}
