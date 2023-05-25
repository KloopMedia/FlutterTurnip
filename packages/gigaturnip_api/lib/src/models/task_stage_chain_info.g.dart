// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_stage_chain_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStageChainInfo _$TaskStageChainInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TaskStageChainInfo',
      json,
      ($checkedConvert) {
        final val = TaskStageChainInfo(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          assignType: $checkedConvert('assign_type', (v) => v as String),
          inStages: $checkedConvert('in_stages',
              (v) => (v as List<dynamic>).map((e) => e as int?).toList()),
          outStages: $checkedConvert('out_stages',
              (v) => (v as List<dynamic>).map((e) => e as int?).toList()),
          totalCount: $checkedConvert('total_count', (v) => v as int),
          completeCount: $checkedConvert('complete_count', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'assignType': 'assign_type',
        'inStages': 'in_stages',
        'outStages': 'out_stages',
        'totalCount': 'total_count',
        'completeCount': 'complete_count'
      },
    );
