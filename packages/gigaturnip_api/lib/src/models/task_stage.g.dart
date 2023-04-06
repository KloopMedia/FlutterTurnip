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
          chain: $checkedConvert('chain', (v) => v as int),
          campaign: $checkedConvert('campaign', (v) => v as int),
          cardJsonSchema: $checkedConvert(
              'card_json_schema', (v) => TaskStage._stringToMap(v as String?)),
          cardUiSchema: $checkedConvert(
              'card_ui_schema', (v) => TaskStage._stringToMap(v as String?)),
        );
        return val;
      },
      fieldKeyMap: const {
        'cardJsonSchema': 'card_json_schema',
        'cardUiSchema': 'card_ui_schema'
      },
    );
