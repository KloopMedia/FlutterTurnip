import 'package:json_annotation/json_annotation.dart';

part 'task_stage_chain_info.g.dart';

@JsonSerializable()
class TaskStageChainInfo {
  final int id;
  final String name;
  final String assignType;
  final List<int?> inStages;
  final List<int?> outStages;
  final List<int> completed;
  final List<int> reopened;
  final List<int> opened;
  final int? test;

  const TaskStageChainInfo({
    required this.id,
    required this.name,
    required this.assignType,
    required this.inStages,
    required this.outStages,
    required this.completed,
    required this.reopened,
    required this.opened,
    this.test,
  });

  factory TaskStageChainInfo.fromJson(Map<String, dynamic> json) {
    return _$TaskStageChainInfoFromJson(json);
  }
}