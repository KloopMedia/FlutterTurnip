import 'package:gigaturnip_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final int id;
  final Map<String, dynamic>? responses;
  final bool complete;
  final bool? forceComplete;
  final bool? reopened;
  final TaskStage stage;
  final Case? case_;
  final int? assignee;
  final List<int> inTasks;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Task({
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
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }
}
