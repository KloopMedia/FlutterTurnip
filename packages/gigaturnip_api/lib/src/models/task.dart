
import 'package:gigaturnip_api/src/models/case.dart';
import 'package:gigaturnip_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final int id;
  final Map<String, dynamic>? responses;
  final bool complete;
  final bool forceComplete;
  final bool reopened;
  final Stage stage;
  final Case case_;
  final int? assignee;
  final List<Task> inTasks;

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
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }
}
