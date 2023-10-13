import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Task;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task extends Equatable {
  final int id;
  final String name;
  final Map<String, dynamic>? responses;
  final bool complete;
  final bool reopened;
  final TaskStage stage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? cardJsonSchema;
  final Map<String, dynamic>? cardUiSchema;
  final bool createdOffline;
  final bool submittedOffline;

  const Task({
    required this.id,
    required this.name,
    required this.responses,
    required this.complete,
    required this.reopened,
    required this.stage,
    required this.createdAt,
    required this.updatedAt,
    required this.cardJsonSchema,
    required this.cardUiSchema,
    this.createdOffline = false,
    this.submittedOffline = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }

  factory Task.blank(TaskStage stage, bool offline) {
    return Task(
      id: Random().nextInt(100000000),
      name: stage.name,
      responses: {},
      complete: false,
      reopened: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      cardJsonSchema: stage.cardJsonSchema,
      cardUiSchema: stage.cardUiSchema,
      stage: stage,
      createdOffline: offline,
      submittedOffline: false,
    );
  }

  factory Task.fromApiModel(api.Task model) {
    return Task(
      id: model.id,
      name: model.stage.name,
      responses: model.responses,
      complete: model.complete,
      reopened: model.reopened ?? false,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      cardJsonSchema: model.stage.cardJsonSchema,
      cardUiSchema: model.stage.cardUiSchema,
      stage: TaskStage.fromApiModel(model.stage),
    );
  }

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({Map<String, dynamic>? responses, bool? complete, Map<String, dynamic>? schema}) {
    return Task(
      id: id,
      name: name,
      reopened: reopened,
      createdAt: createdAt,
      updatedAt: updatedAt,
      stage: stage,
      cardJsonSchema: cardJsonSchema,
      cardUiSchema: cardUiSchema,
      responses: responses ?? this.responses,
      complete: complete ?? this.complete,
    );
  }

  @override
  List<Object?> get props => [id, responses, complete, reopened, stage];
}
