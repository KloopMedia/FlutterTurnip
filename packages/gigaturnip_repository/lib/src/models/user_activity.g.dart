// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivity _$UserActivityFromJson(Map<String, dynamic> json) => UserActivity(
      stage: json['stage'] as int,
      stageName: json['stageName'] as String,
      chain: json['chain'] as int,
      chainName: json['chainName'] as String,
      ranks: (json['ranks'] as List<dynamic>).map((e) => e as int?).toList(),
      inStages:
          (json['inStages'] as List<dynamic>).map((e) => e as int?).toList(),
      outStages:
          (json['outStages'] as List<dynamic>).map((e) => e as int?).toList(),
      completeTrue: json['completeTrue'] as int,
      completeFalse: json['completeFalse'] as int,
      forceCompleteTrue: json['forceCompleteTrue'] as int,
      forceCompleteFalse: json['forceCompleteFalse'] as int,
      countTasks: json['countTasks'] as int,
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
