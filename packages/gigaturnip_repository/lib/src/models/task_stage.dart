import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show TaskStage;
import 'package:json_annotation/json_annotation.dart';
import 'package:local_database/local_database.dart' as db;

part 'task_stage.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskStage extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int chain;
  final int campaign;
  final Map<String, dynamic>? cardJsonSchema;
  final Map<String, dynamic>? cardUiSchema;

  const TaskStage({
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

  factory TaskStage.fromApiModel(api.TaskStage model) {
    return TaskStage(
      id: model.id,
      name: model.name,
      description: model.description,
      chain: model.chain,
      campaign: model.campaign,
      cardJsonSchema: model.cardJsonSchema,
      cardUiSchema: model.cardUiSchema,
    );
  }

  db.TaskStageCompanion toDB() {
    return db.TaskStageCompanion.insert(
      id: Value(id),
      name: name,
      description: Value(description),
      chain: chain,
      campaign: campaign,
    );
  }

  factory TaskStage.fromDB(db.TaskStageData model) {
    return TaskStage(
      id: model.id,
      name: model.name,
      description: model.description,
      cardJsonSchema: jsonDecode(model.cardJsonSchema ?? "{}"),
      cardUiSchema: jsonDecode(model.cardUiSchema ?? "{}"),
      chain: model.chain,
      campaign: model.campaign,
    );
  }

  Map<String, dynamic> toJson() => _$TaskStageToJson(this);

  @override
  List<Object?> get props => [id, name, description, chain];
}
