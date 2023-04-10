import 'package:json_annotation/json_annotation.dart';

import '../../gigaturnip_api.dart';

part 'task_detail.g.dart';

@JsonSerializable()
class TaskDetail {
  final int id;
  final Map<String, dynamic>? responses;
  final bool complete;
  final bool? forceComplete;
  final bool? reopened;
  final TaskStageDetail stage;
  final Case? case_;
  final int? assignee;
  final List<int> inTasks;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<int>? displayedPrevTasks;
  final Map<String, dynamic>? integratorGroup;
  final DateTime? startPeriod;
  final DateTime? endPeriod;

  const TaskDetail({
    required this.id,
    required this.responses,
    required this.complete,
    required this.reopened,
    required this.forceComplete,
    required this.stage,
    required this.assignee,
    required this.case_,
    required this.inTasks,
    required this.createdAt,
    required this.updatedAt,
    required this.displayedPrevTasks,
    required this.integratorGroup,
    required this.startPeriod,
    required this.endPeriod,
  });

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return _$TaskDetailFromJson(json);
  }
}
