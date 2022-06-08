import 'package:gigaturnip_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final int id;
  final Map<String, dynamic>? responses;
  final bool complete;
  final bool reopened;
  final Stage stage;
  final int assignee;

  const Task({
    required this.id,
    required this.responses,
    required this.complete,
    required this.reopened,
    required this.stage,
    required this.assignee,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }
}
