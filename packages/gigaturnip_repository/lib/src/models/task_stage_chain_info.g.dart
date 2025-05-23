// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_stage_chain_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStageChainInfo _$TaskStageChainInfoFromJson(Map<String, dynamic> json) =>
    TaskStageChainInfo(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      outStages: (json['outStages'] as List<dynamic>)
          .map((e) => (e as num?)?.toInt())
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      completeCount: (json['completeCount'] as num).toInt(),
      completed: (json['completed'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      reopened: (json['reopened'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      opened: (json['opened'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      test: (json['test'] as num?)?.toInt(),
      richText: json['richText'] as String?,
    );

Map<String, dynamic> _$TaskStageChainInfoToJson(TaskStageChainInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'outStages': instance.outStages,
      'completed': instance.completed,
      'reopened': instance.reopened,
      'opened': instance.opened,
      'totalCount': instance.totalCount,
      'completeCount': instance.completeCount,
      'test': instance.test,
      'richText': instance.richText,
    };
