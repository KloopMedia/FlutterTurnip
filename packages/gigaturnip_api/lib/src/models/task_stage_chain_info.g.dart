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
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          outStages: $checkedConvert(
              'out_stages',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num?)?.toInt())
                  .toList()),
          completed: $checkedConvert(
              'completed',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => (e as num).toInt())
                      .toList() ??
                  const []),
          reopened: $checkedConvert(
              'reopened',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => (e as num).toInt())
                      .toList() ??
                  const []),
          opened: $checkedConvert(
              'opened',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => (e as num).toInt())
                      .toList() ??
                  const []),
          test: $checkedConvert('test', (v) => (v as num?)?.toInt()),
          richText: $checkedConvert('rich_text', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'outStages': 'out_stages', 'richText': 'rich_text'},
    );
