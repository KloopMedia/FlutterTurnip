// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      responses: json['responses'] as Map<String, dynamic>?,
      complete: json['complete'] as bool,
      reopened: json['reopened'] as bool,
      stage: Stage.fromJson(json['stage'] as Map<String, dynamic>),
      assignee: json['assignee'] as int,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'responses': instance.responses,
      'complete': instance.complete,
      'reopened': instance.reopened,
      'stage': instance.stage,
      'assignee': instance.assignee,
    };
