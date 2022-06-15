import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Task;

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final int id;
  final String name;
  final Map<String, dynamic>? responses;
  final bool complete;
  final bool reopened;
  final TaskStage stage;

  const Task({
    required this.id,
    required this.name,
    required this.responses,
    required this.complete,
    required this.reopened,
    required this.stage,
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
      reopened: model.reopened,
      stage: TaskStage.fromApiModel(model.stage),
    );
  }

  @override
  List<Object?> get props => [id, responses, complete, reopened, stage];
}
