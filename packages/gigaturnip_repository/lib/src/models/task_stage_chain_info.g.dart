// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_stage_chain_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStageChainInfo _$TaskStageChainInfoFromJson(Map<String, dynamic> json) =>
    TaskStageChainInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      assignType: json['assignType'] as String,
      inStages:
          (json['inStages'] as List<dynamic>).map((e) => e as int?).toList(),
      outStages:
          (json['outStages'] as List<dynamic>).map((e) => e as int?).toList(),
      totalCount: json['totalCount'] as int,
      completeCount: json['completeCount'] as int,
      completed:
          (json['completed'] as List<dynamic>).map((e) => e as int).toList(),
      reopened:
          (json['reopened'] as List<dynamic>).map((e) => e as int).toList(),
      opened: (json['opened'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$TaskStageChainInfoToJson(TaskStageChainInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'assignType': instance.assignType,
      'inStages': instance.inStages,
      'outStages': instance.outStages,
      'completed': instance.completed,
      'reopened': instance.reopened,
      'opened': instance.opened,
      'totalCount': instance.totalCount,
      'completeCount': instance.completeCount,
    };
