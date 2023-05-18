// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStage _$TaskStageFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TaskStage',
      json,
      ($checkedConvert) {
        final val = TaskStage(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
          chain: $checkedConvert('chain', (v) => v as int?),
          campaign: $checkedConvert('campaign', (v) => v as int?),
          cardJsonSchema: $checkedConvert(
              'card_json_schema', (v) => TaskStage._stringToMap(v as String?)),
          cardUiSchema: $checkedConvert(
              'card_ui_schema', (v) => TaskStage._stringToMap(v as String?)),
          assignType: $checkedConvert('assign_type', (v) => v as String?),
          inStages: $checkedConvert('in_stages',
              (v) => (v as List<dynamic>?)?.map((e) => e as int?).toList()),
          outStages: $checkedConvert('out_stages',
              (v) => (v as List<dynamic>?)?.map((e) => e as int?).toList()),
          totalCount: $checkedConvert('total_count', (v) => v as int?),
          completeCount: $checkedConvert('complete_count', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'cardJsonSchema': 'card_json_schema',
        'cardUiSchema': 'card_ui_schema',
        'assignType': 'assign_type',
        'inStages': 'in_stages',
        'outStages': 'out_stages',
        'totalCount': 'total_count',
        'completeCount': 'complete_count'
      },
    );
