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
      availableTo: json['availableTo'] == null
          ? null
          : DateTime.parse(json['availableTo'] as String),
      availableFrom: json['availableFrom'] == null
          ? null
          : DateTime.parse(json['availableFrom'] as String),
      stageType: convertStringToStageType(json['stageType'] as String?),
      takeTaskButtonText: json['takeTaskButtonText'] as String?,
      externalRendererUrl: json['externalRendererUrl'] as String?,
      openLimit: json['openLimit'] as int? ?? 0,
      totalLimit: json['totalLimit'] as int? ?? 0,
    );

Map<String, dynamic> _$TaskStageToJson(TaskStage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'chain': instance.chain,
      'campaign': instance.campaign,
      'cardJsonSchema': instance.cardJsonSchema,
      'cardUiSchema': instance.cardUiSchema,
      'availableTo': instance.availableTo?.toIso8601String(),
      'availableFrom': instance.availableFrom?.toIso8601String(),
      'stageType': convertStageTypeToString(instance.stageType),
      'openLimit': instance.openLimit,
      'totalLimit': instance.totalLimit,
      'takeTaskButtonText': instance.takeTaskButtonText,
      'externalRendererUrl': instance.externalRendererUrl,
    };
