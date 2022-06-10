import 'package:json_annotation/json_annotation.dart';

part 'task_stage.g.dart';

@JsonSerializable()
class TaskStage {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;


  TaskStage({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });


  factory TaskStage.fromJson(Map<String, dynamic> json) {
    return _$TaskStageFromJson(json);
  }
}
