// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'user_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivity _$UserActivityFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserActivity',
      json,
      ($checkedConvert) {
        final val = UserActivity(
          stage: $checkedConvert('stage', (v) => (v as num).toInt()),
          stageName: $checkedConvert('stage_name', (v) => v as String),
          chain: $checkedConvert('chain', (v) => (v as num).toInt()),
          chainName: $checkedConvert('chain_name', (v) => v as String),
          ranks: $checkedConvert(
              'ranks',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num?)?.toInt())
                  .toList()),
          inStages: $checkedConvert(
              'in_stages',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num?)?.toInt())
                  .toList()),
          outStages: $checkedConvert(
              'out_stages',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num?)?.toInt())
                  .toList()),
          completeTrue:
              $checkedConvert('complete_true', (v) => (v as num).toInt()),
          completeFalse:
              $checkedConvert('complete_false', (v) => (v as num).toInt()),
          forceCompleteTrue:
              $checkedConvert('force_complete_true', (v) => (v as num).toInt()),
          forceCompleteFalse: $checkedConvert(
              'force_complete_false', (v) => (v as num).toInt()),
          countTasks: $checkedConvert('count_tasks', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'stageName': 'stage_name',
        'chainName': 'chain_name',
        'inStages': 'in_stages',
        'outStages': 'out_stages',
        'completeTrue': 'complete_true',
        'completeFalse': 'complete_false',
        'forceCompleteTrue': 'force_complete_true',
        'forceCompleteFalse': 'force_complete_false',
        'countTasks': 'count_tasks'
      },
    );
