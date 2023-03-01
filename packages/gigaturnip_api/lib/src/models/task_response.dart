import 'package:json_annotation/json_annotation.dart';

part 'task_response.g.dart';

@JsonSerializable()
class TaskResponse {
  final String message;
  final int id;
  final int? nextDirectId;

  TaskResponse({
    this.message = "",
    required this.id,
    required this.nextDirectId,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return _$TaskResponseFromJson(json);
  }
}
