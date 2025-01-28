import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show TaskStageChainInfo;

part 'task_stage_chain_info.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskStageChainInfo extends Equatable {
  final int id;
  final String name;
  final List<int?> outStages;
  final List<int> completed;
  final List<int> reopened;
  final List<int> opened;
  final int totalCount;
  final int completeCount;
  final int? test;
  final String? richText;

  const TaskStageChainInfo({
    required this.id,
    required this.name,
    required this.outStages,
    required this.totalCount,
    required this.completeCount,
    required this.completed,
    required this.reopened,
    required this.opened,
    this.test,
    this.richText,
  });

  factory TaskStageChainInfo.fromJson(Map<String, dynamic> json) {
    return _$TaskStageChainInfoFromJson(json);
  }

  factory TaskStageChainInfo.fromApiModel(api.TaskStageChainInfo model) {
    return TaskStageChainInfo(
      id: model.id,
      name: model.name,
      outStages: model.outStages,
      totalCount: model.completed.length + model.opened.length,
      completeCount: model.completed.length,
      completed: model.completed,
      reopened: model.reopened,
      opened: model.opened,
      test: model.test,
      richText: model.richText
    );
  }

  Map<String, dynamic> toJson() => _$TaskStageChainInfoToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    outStages,
    totalCount,
    completeCount,
    completed,
    reopened,
    opened,
  ];
}