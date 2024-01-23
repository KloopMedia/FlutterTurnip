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
          availableTo: $checkedConvert('available_to',
              (v) => v == null ? null : DateTime.parse(v as String)),
          availableFrom: $checkedConvert('available_from',
              (v) => v == null ? null : DateTime.parse(v as String)),
          stageType: $checkedConvert('stage_type', (v) => v as String?),
          rankLimit: $checkedConvert(
              'rank_limit',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as int),
                  )),
          takeTaskButtonText:
              $checkedConvert('take_task_button_text', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'cardJsonSchema': 'card_json_schema',
        'cardUiSchema': 'card_ui_schema',
        'availableTo': 'available_to',
        'availableFrom': 'available_from',
        'stageType': 'stage_type',
        'rankLimit': 'rank_limit',
        'takeTaskButtonText': 'take_task_button_text'
      },
    );
