// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStage _$TaskStageFromJson(Map<String, dynamic> json) => TaskStage(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      chain: json['chain'] as int,
      campaign: json['campaign'] as int,
      cardJsonSchema: json['cardJsonSchema'] as Map<String, dynamic>?,
      cardUiSchema: json['cardUiSchema'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$TaskStageToJson(TaskStage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'chain': instance.chain,
      'campaign': instance.campaign,
      'cardJsonSchema': instance.cardJsonSchema,
      'cardUiSchema': instance.cardUiSchema,
    };
