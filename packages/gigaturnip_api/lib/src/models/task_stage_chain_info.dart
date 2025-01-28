import 'package:json_annotation/json_annotation.dart';

part 'task_stage_chain_info.g.dart';

@JsonSerializable()
class TaskStageChainInfo {
  final int id;
  final String name;
  final List<int?> outStages;
  final List<int> completed;
  final List<int> reopened;
  final List<int> opened;
  final int? test;
  final String? richText;

  const TaskStageChainInfo({
    required this.id,
    required this.name,
    required this.outStages,
    this.completed = const [],
    this.reopened = const [],
    this.opened = const [],
    this.test,
    this.richText,
  });

  factory TaskStageChainInfo.fromJson(Map<String, dynamic> json) {
    return _$TaskStageChainInfoFromJson(json);
  }
}