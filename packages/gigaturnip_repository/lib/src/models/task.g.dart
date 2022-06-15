// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      name: json['name'] as String,
      responses: json['responses'] as Map<String, dynamic>?,
      complete: json['complete'] as bool,
      reopened: json['reopened'] as bool,
      stage: TaskStage.fromJson(json['stage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'responses': instance.responses,
      'complete': instance.complete,
      'reopened': instance.reopened,
      'stage': instance.stage,
    };
