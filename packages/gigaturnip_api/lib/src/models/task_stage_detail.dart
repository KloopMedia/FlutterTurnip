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
  final List<int> inStages;
  final List<int> outStages;
  @JsonKey(fromJson: _stringToDouble, toJson: _stringFromDouble)
  final double xPos;
  @JsonKey(fromJson: _stringToDouble, toJson: _stringFromDouble)
  final double yPos;
  @JsonKey(fromJson: _stringToMap, toJson: _stringFromMap)
  final Map<String, dynamic> jsonSchema;
  @JsonKey(fromJson: _stringToMap, toJson: _stringFromMap)
  final Map<String, dynamic> uiSchema;
  final String? library;
  final bool copyInput;
  final bool allowMultipleFiles;
  final bool isCreatable;
  final List<int> displayedPrevStages;
  final String? assignUserBy;
  final int? assignUserFromStage;
  final List<int> ranks;
  final String? richText;
  final String? webhookAddress;
  final String? webhookPlayloadField;
  final String? webhookParams;
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
    required this.inStages,
    required this.outStages,
    required this.yPos,
    required this.xPos,
    required this.jsonSchema,
    required this.uiSchema,
    required this.library,
    required this.copyInput,
    required this.allowMultipleFiles,
    required this.isCreatable,
    required this.displayedPrevStages,
    required this.assignUserBy,
    required this.assignUserFromStage,
    required this.ranks,
    required this.richText,
    required this.webhookAddress,
    required this.webhookPlayloadField,
    required this.webhookParams,
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

  static double _stringToDouble(String number) => double.parse(number);

  static String _stringFromDouble(double number) => number.toString();

  static Map<String, dynamic> _stringToMap(String? json) {
    try {
      return json != null ? jsonDecode(json) : {};
    } catch (e) {
      return {};
    }
  }

  static String _stringFromMap(Map<String, dynamic> json) => jsonEncode(json);
}
