// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivity _$UserActivityFromJson(Map<String, dynamic> json) => UserActivity(
      stage: (json['stage'] as num).toInt(),
      stageName: json['stageName'] as String,
      chain: (json['chain'] as num).toInt(),
      chainName: json['chainName'] as String,
      ranks: (json['ranks'] as List<dynamic>)
          .map((e) => (e as num?)?.toInt())
          .toList(),
      inStages: (json['inStages'] as List<dynamic>)
          .map((e) => (e as num?)?.toInt())
          .toList(),
      outStages: (json['outStages'] as List<dynamic>)
          .map((e) => (e as num?)?.toInt())
          .toList(),
      completeTrue: (json['completeTrue'] as num).toInt(),
      completeFalse: (json['completeFalse'] as num).toInt(),
      forceCompleteTrue: (json['forceCompleteTrue'] as num).toInt(),
      forceCompleteFalse: (json['forceCompleteFalse'] as num).toInt(),
      countTasks: (json['countTasks'] as num).toInt(),
    );

Map<String, dynamic> _$UserActivityToJson(UserActivity instance) =>
    <String, dynamic>{
      'stage': instance.stage,
      'stageName': instance.stageName,
      'chain': instance.chain,
      'chainName': instance.chainName,
      'ranks': instance.ranks,
      'inStages': instance.inStages,
      'outStages': instance.outStages,
      'completeTrue': instance.completeTrue,
      'completeFalse': instance.completeFalse,
      'forceCompleteTrue': instance.forceCompleteTrue,
      'forceCompleteFalse': instance.forceCompleteFalse,
      'countTasks': instance.countTasks,
    };
