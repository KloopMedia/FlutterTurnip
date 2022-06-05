import 'package:flutter/foundation.dart' show immutable;
import 'package:gigaturnip/services/api/models/api_stage.dart';

@immutable
class ApiTask {
  final int id;
  final Map<String, dynamic>? responses;
  final bool complete;
  final bool reopened;
  final ApiStage stage;
  final int assignee;

  const ApiTask({
    required this.id,
    required this.responses,
    required this.complete,
    required this.reopened,
    required this.stage,
    required this.assignee,
  });

  factory ApiTask.fromJson(Map<String, dynamic> json) {
    return ApiTask(
      id: json['id'],
      responses: json['responses'],
      complete: json['complete'],
      reopened: json['reopened'],
      stage: ApiStage.fromJson(json['stage']),
      assignee: json['assignee'],
    );
  }
}
