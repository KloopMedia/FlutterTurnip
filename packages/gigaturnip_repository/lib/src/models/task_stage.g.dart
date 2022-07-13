// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStage _$TaskStageFromJson(Map<String, dynamic> json) => TaskStage(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      chain: Chain.fromJson(json['chain'] as Map<String, dynamic>),
      richText: json['richText'] as String?,
    );

Map<String, dynamic> _$TaskStageToJson(TaskStage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'chain': instance.chain.toJson(),
      'richText': instance.richText,
    };
