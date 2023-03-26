import 'package:json_annotation/json_annotation.dart';

part 'create_task_response.g.dart';

@JsonSerializable()
class CreateTaskResponse {
  final String status;
  final int id;

  CreateTaskResponse({this.status = "", required this.id});

  factory CreateTaskResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateTaskResponseFromJson(json);
  }
}