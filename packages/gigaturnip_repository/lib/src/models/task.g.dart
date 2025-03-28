// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      responses: json['responses'] as Map<String, dynamic>?,
      complete: json['complete'] as bool,
      reopened: json['reopened'] as bool,
      stage: TaskStage.fromJson(json['stage'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      cardJsonSchema: json['cardJsonSchema'] as Map<String, dynamic>?,
      cardUiSchema: json['cardUiSchema'] as Map<String, dynamic>?,
      createdOffline: json['createdOffline'] as bool? ?? false,
      submittedOffline: json['submittedOffline'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'responses': instance.responses,
      'complete': instance.complete,
      'reopened': instance.reopened,
      'stage': instance.stage.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'cardJsonSchema': instance.cardJsonSchema,
      'cardUiSchema': instance.cardUiSchema,
      'createdOffline': instance.createdOffline,
      'submittedOffline': instance.submittedOffline,
    };
