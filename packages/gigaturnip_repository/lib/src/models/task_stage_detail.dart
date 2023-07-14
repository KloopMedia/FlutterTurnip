import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:json_annotation/json_annotation.dart';
import 'package:local_database/local_database.dart' as db;

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
  final bool allowRelease;
  final bool allowGoBack;

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
    required this.allowRelease,
    required this.allowGoBack,
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
    );
  }

  Map<String, dynamic> toJson() => _$TaskStageDetailToJson(this);

  db.TaskStageCompanion toDB() {
    return db.TaskStageCompanion.insert(
      id: Value(id),
      name: name,
      description: Value(description),
      chain: chain,
      campaign: campaign,
      richText: Value(richText),
      jsonSchema: Value(jsonEncode(jsonSchema)),
      uiSchema: Value(jsonEncode(uiSchema)),
    );
  }

  factory TaskStageDetail.fromDB(db.TaskStageData model) {
    return TaskStageDetail(
      id: model.id,
      name: model.name,
      description: model.description,
      cardJsonSchema: jsonDecode(model.cardJsonSchema ?? "{}"),
      cardUiSchema: jsonDecode(model.cardUiSchema ?? "{}"),
      chain: model.chain,
      campaign: model.campaign,
      jsonSchema: jsonDecode(model.jsonSchema ?? "{}"),
      uiSchema: jsonDecode(model.uiSchema ?? "{}"),
      richText: model.richText,
      dynamicJsonsSource: [],
      dynamicJsonsTarget: [],
      allowGoBack: false,
      allowRelease: false,
    );
  }

  @override
  List<Object?> get props => [id, name, description, chain, richText];
}
