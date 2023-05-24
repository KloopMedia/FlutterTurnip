import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'task_stage.g.dart';

@JsonSerializable()
class TaskStage {
  final int id;
  final String name;
  final String? description;
  final int chain;
  final int campaign;
  @JsonKey(fromJson: _stringToMap, toJson: _stringFromMap)
  final Map<String, dynamic> cardJsonSchema;
  @JsonKey(fromJson: _stringToMap, toJson: _stringFromMap)
  final Map<String, dynamic> cardUiSchema;

  TaskStage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
    required this.campaign,
    required this.cardJsonSchema,
    required this.cardUiSchema,
  });

  factory TaskStage.fromJson(Map<String, dynamic> json) {
    return _$TaskStageFromJson(json);
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
