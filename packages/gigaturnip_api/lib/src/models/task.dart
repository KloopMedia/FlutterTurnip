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
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Task({
    required this.id,
    required this.responses,
    required this.complete,
    required this.reopened,
    required this.forceComplete,
    required this.stage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }
}
