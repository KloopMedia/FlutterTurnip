import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show TaskStage;

part 'task_stage.g.dart';

@JsonSerializable()
class TaskStage extends Equatable {
  final int id;
  final String name;
  final String description;
  final Chain chain;

  const TaskStage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
  });

  factory TaskStage.fromJson(Map<String, dynamic> json) {
    return _$TaskStageFromJson(json);
  }

  factory TaskStage.fromApiModel(api.TaskStage model) {
    return TaskStage(
      id: model.id,
      name: model.name,
      description: model.description,
      chain: Chain.fromApiModel(model.chain),
    );
  }

  @override
  List<Object?> get props => [id, name, description, chain];
}
