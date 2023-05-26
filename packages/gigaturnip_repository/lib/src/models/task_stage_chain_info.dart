import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show TaskStageChainInfo;

part 'task_stage_chain_info.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskStageChainInfo extends Equatable {
  final int id;
  final String name;
  final String assignType;
  final List<int?> inStages;
  final List<int?> outStages;
  final int totalCount;
  final int completeCount;

  const TaskStageChainInfo({
    required this.id,
    required this.name,
    required this.assignType,
    required this.inStages,
    required this.outStages,
    required this.totalCount,
    required this.completeCount,
  });

  factory TaskStageChainInfo.fromJson(Map<String, dynamic> json) {
    return _$TaskStageChainInfoFromJson(json);
  }

  factory TaskStageChainInfo.fromApiModel(api.TaskStageChainInfo model) {
    return TaskStageChainInfo(
      id: model.id,
      name: model.name,
      assignType: model.assignType,
      inStages: model.inStages,
      outStages: model.outStages,
      totalCount: model.totalCount,
      completeCount: model.completeCount,
    );
  }

  Map<String, dynamic> toJson() => _$TaskStageChainInfoToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    assignType,
    inStages,
    outStages,
    totalCount,
    completeCount
  ];
}