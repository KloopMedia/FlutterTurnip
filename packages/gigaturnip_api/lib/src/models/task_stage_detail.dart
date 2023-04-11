import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'task_stage_detail.g.dart';

@JsonSerializable()
class TaskStageDetail {
  final int id;
  final String name;
  final String description;
  final int chain;
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

  TaskStageDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
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
