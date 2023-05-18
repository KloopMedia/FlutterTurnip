// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStage _$TaskStageFromJson(Map<String, dynamic> json) => TaskStage(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      chain: json['chain'] as int?,
      campaign: json['campaign'] as int?,
      cardJsonSchema: json['cardJsonSchema'] as Map<String, dynamic>?,
      cardUiSchema: json['cardUiSchema'] as Map<String, dynamic>?,
      assignType: json['assignType'] as String?,
      inStages:
          (json['inStages'] as List<dynamic>?)?.map((e) => e as int?).toList(),
      outStages:
          (json['outStages'] as List<dynamic>?)?.map((e) => e as int?).toList(),
      totalCount: json['totalCount'] as int?,
      completeCount: json['completeCount'] as int?,
    );

Map<String, dynamic> _$TaskStageToJson(TaskStage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'chain': instance.chain,
      'campaign': instance.campaign,
      'cardJsonSchema': instance.cardJsonSchema,
      'cardUiSchema': instance.cardUiSchema,
      'assignType': instance.assignType,
      'inStages': instance.inStages,
      'outStages': instance.outStages,
      'totalCount': instance.totalCount,
      'completeCount': instance.completeCount,
    };
