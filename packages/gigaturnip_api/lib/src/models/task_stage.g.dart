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
          description: $checkedConvert('description', (v) => v as String),
          chain: $checkedConvert(
              'chain', (v) => Chain.fromJson(v as Map<String, dynamic>)),
          inStages: $checkedConvert('in_stages',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          outStages: $checkedConvert('out_stages',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          yPos: $checkedConvert(
              'y_pos', (v) => TaskStage._stringToDouble(v as String)),
          xPos: $checkedConvert(
              'x_pos', (v) => TaskStage._stringToDouble(v as String)),
          jsonSchema: $checkedConvert(
              'json_schema', (v) => TaskStage._stringToMap(v as String?)),
          uiSchema: $checkedConvert(
              'ui_schema', (v) => TaskStage._stringToMap(v as String?)),
          library: $checkedConvert('library', (v) => v as String?),
          copyInput: $checkedConvert('copy_input', (v) => v as bool),
          allowMultipleFiles:
              $checkedConvert('allow_multiple_files', (v) => v as bool),
          isCreatable: $checkedConvert('is_creatable', (v) => v as bool),
          displayedPrevStages: $checkedConvert('displayed_prev_stages',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          assignUserBy: $checkedConvert('assign_user_by', (v) => v as String?),
          assignUserFromStage:
              $checkedConvert('assign_user_from_stage', (v) => v as int?),
          ranks: $checkedConvert('ranks',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          richText: $checkedConvert('rich_text', (v) => v as String?),
          webhookAddress:
              $checkedConvert('webhook_address', (v) => v as String?),
          webhookPlayloadField:
              $checkedConvert('webhook_playload_field', (v) => v as String?),
          webhookParams: $checkedConvert('webhook_params', (v) => v as String?),
          dynamicJsons:
              $checkedConvert('dynamic_jsons', (v) => v as List<dynamic>),
          webhookResponseField:
              $checkedConvert('webhook_response_field', (v) => v as String?),
          allowGoBack: $checkedConvert('allow_go_back', (v) => v as bool),
          allowRelease: $checkedConvert('allow_release', (v) => v as bool),
          externalMetadata: $checkedConvert(
              'external_metadata', (v) => v as Map<String, dynamic>?),
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
        'assignUserFromStage': 'assign_user_from_stage',
        'richText': 'rich_text',
        'webhookAddress': 'webhook_address',
        'webhookPlayloadField': 'webhook_playload_field',
        'webhookParams': 'webhook_params',
        'dynamicJsons': 'dynamic_jsons',
        'webhookResponseField': 'webhook_response_field',
        'allowGoBack': 'allow_go_back',
        'allowRelease': 'allow_release',
        'externalMetadata': 'external_metadata'
      },
    );
