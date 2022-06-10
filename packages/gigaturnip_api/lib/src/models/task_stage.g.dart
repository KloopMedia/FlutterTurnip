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
          chain: $checkedConvert(
              'chain',
              (v) => (v as List<dynamic>)
                  .map((e) => Chain.fromJson(e as Map<String, dynamic>))
                  .toList()),
          inStages: $checkedConvert('in_stages',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          outStages: $checkedConvert('out_stages',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          yPos: $checkedConvert('y_pos', (v) => v as int),
          xPos: $checkedConvert('x_pos', (v) => v as int),
          jsonSchema: $checkedConvert('json_schema',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          uiSchema: $checkedConvert('ui_schema',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          library: $checkedConvert('library', (v) => v as String),
          copyInput: $checkedConvert('copy_input', (v) => v as bool),
          allowMultipleFiles:
              $checkedConvert('allow_multiple_files', (v) => v as bool),
          isCreatable: $checkedConvert('is_creatable', (v) => v as bool),
          displayedPrevStages: $checkedConvert('displayed_prev_stages',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          assignUserBy: $checkedConvert('assign_user_by', (v) => v as String),
          richText: $checkedConvert('rich_text', (v) => v as String),
          webhookAddress:
              $checkedConvert('webhook_address', (v) => v as String),
          webhookPlayloadFields:
              $checkedConvert('webhook_playload_fields', (v) => v as String),
          webhookParams: $checkedConvert('webhook_params', (v) => v as String),
          dynamicJsons:
              $checkedConvert('dynamic_jsons', (v) => v as List<dynamic>),
          webhookResponseField:
              $checkedConvert('webhook_response_field', (v) => v as String),
          allowGoBack: $checkedConvert('allow_go_back', (v) => v as bool),
          allowRelease: $checkedConvert('allow_release', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'inStages': 'in_stages',
        'outStages': 'out_stages',
        'yPos': 'y_pos',
        'xPos': 'x_pos',
        'jsonSchema': 'json_schema',
        'uiSchema': 'ui_schema',
        'copyInput': 'copy_input',
        'allowMultipleFiles': 'allow_multiple_files',
        'isCreatable': 'is_creatable',
        'displayedPrevStages': 'displayed_prev_stages',
        'assignUserBy': 'assign_user_by',
        'richText': 'rich_text',
        'webhookAddress': 'webhook_address',
        'webhookPlayloadFields': 'webhook_playload_fields',
        'webhookParams': 'webhook_params',
        'dynamicJsons': 'dynamic_jsons',
        'webhookResponseField': 'webhook_response_field',
        'allowGoBack': 'allow_go_back',
        'allowRelease': 'allow_release'
      },
    );
