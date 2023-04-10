// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDetail _$TaskDetailFromJson(Map<String, dynamic> json) => TaskDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      responses: json['responses'] as Map<String, dynamic>?,
      complete: json['complete'] as bool,
      reopened: json['reopened'] as bool,
      stage: TaskStageDetail.fromJson(json['stage'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      schema: json['schema'] as Map<String, dynamic>?,
      uiSchema: json['uiSchema'] as Map<String, dynamic>?,
      cardJsonSchema: json['cardJsonSchema'] as Map<String, dynamic>?,
      cardUiSchema: json['cardUiSchema'] as Map<String, dynamic>?,
      displayedPrevTasks: (json['displayedPrevTasks'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      isIntegrated: json['isIntegrated'] as bool,
      dynamicSource: (json['dynamicSource'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      dynamicTarget: (json['dynamicTarget'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      startPeriod: json['startPeriod'] == null
          ? null
          : DateTime.parse(json['startPeriod'] as String),
      endPeriod: json['endPeriod'] == null
          ? null
          : DateTime.parse(json['endPeriod'] as String),
    );

Map<String, dynamic> _$TaskDetailToJson(TaskDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'schema': instance.schema,
      'uiSchema': instance.uiSchema,
      'responses': instance.responses,
      'complete': instance.complete,
      'reopened': instance.reopened,
      'stage': instance.stage.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'cardJsonSchema': instance.cardJsonSchema,
      'cardUiSchema': instance.cardUiSchema,
      'displayedPrevTasks': instance.displayedPrevTasks,
      'isIntegrated': instance.isIntegrated,
      'dynamicSource': instance.dynamicSource,
      'dynamicTarget': instance.dynamicTarget,
      'startPeriod': instance.startPeriod?.toIso8601String(),
      'endPeriod': instance.endPeriod?.toIso8601String(),
    };
