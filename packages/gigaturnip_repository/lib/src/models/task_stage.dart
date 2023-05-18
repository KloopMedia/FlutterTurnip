import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show TaskStage;
import 'package:json_annotation/json_annotation.dart';

part 'task_stage.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskStage extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int? chain;
  final int? campaign;
  final Map<String, dynamic>? cardJsonSchema;
  final Map<String, dynamic>? cardUiSchema;
  final String? assignType;
  final List<int?>? inStages;
  final List<int?>? outStages;
  final int? totalCount;
  final int? completeCount;

  const TaskStage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
    required this.campaign,
    required this.cardJsonSchema,
    required this.cardUiSchema,
    required this.assignType,
    required this.inStages,
    required this.outStages,
    required this.totalCount,
    required this.completeCount,
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
      assignType: model.assignType,
      inStages: model.inStages,
      outStages: model.outStages,
      totalCount: model.totalCount,
      completeCount: model.completeCount,
    );
  }

  Map<String, dynamic> toJson() => _$TaskStageToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    chain,
    assignType,
    inStages,
    outStages,
    totalCount,
    completeCount,
  ];
}
