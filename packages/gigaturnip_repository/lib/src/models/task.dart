import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Task;

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
  final Map<String, dynamic>? cardJsonSchema;
  final Map<String, dynamic>? cardUiSchema;

  const Task({
    required this.id,
    required this.name,
    required this.responses,
    required this.complete,
    required this.reopened,
    required this.stage,
    required this.createdAt,
    required this.cardJsonSchema,
    required this.cardUiSchema,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }

  factory Task.fromApiModel(api.Task model) {
    return Task(
      id: model.id,
      name: model.stage.name,
      responses: model.responses,
      complete: model.complete,
      reopened: model.reopened ?? false,
      createdAt: model.createdAt,
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
