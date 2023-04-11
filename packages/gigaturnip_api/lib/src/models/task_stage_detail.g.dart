// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_stage_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStageDetail _$TaskStageDetailFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TaskStageDetail',
      json,
      ($checkedConvert) {
        final val = TaskStageDetail(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          chain: $checkedConvert('chain', (v) => v as int),
          campaign: $checkedConvert('campaign', (v) => v as int),
          jsonSchema: $checkedConvert(
              'json_schema', (v) => TaskStageDetail._stringToMap(v as String?)),
          uiSchema: $checkedConvert(
              'ui_schema', (v) => TaskStageDetail._stringToMap(v as String?)),
          isCreatable: $checkedConvert('is_creatable', (v) => v as bool),
          richText: $checkedConvert('rich_text', (v) => v as String?),
          dynamicJsonsSource: $checkedConvert(
              'dynamic_jsons_source',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => e as Map<String, dynamic>)
                  .toList()),
          dynamicJsonsTarget: $checkedConvert(
              'dynamic_jsons_target',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => e as Map<String, dynamic>)
                  .toList()),
          webhookResponseField:
              $checkedConvert('webhook_response_field', (v) => v as String?),
          allowGoBack: $checkedConvert('allow_go_back', (v) => v as bool),
          allowRelease: $checkedConvert('allow_release', (v) => v as bool),
          externalMetadata: $checkedConvert(
              'external_metadata', (v) => v as Map<String, dynamic>?),
          cardJsonSchema: $checkedConvert('card_json_schema',
              (v) => TaskStageDetail._stringToMap(v as String?)),
          cardUiSchema: $checkedConvert('card_ui_schema',
              (v) => TaskStageDetail._stringToMap(v as String?)),
        );
        return val;
      },
      fieldKeyMap: const {
        'jsonSchema': 'json_schema',
        'uiSchema': 'ui_schema',
        'isCreatable': 'is_creatable',
        'richText': 'rich_text',
        'dynamicJsonsSource': 'dynamic_jsons_source',
        'dynamicJsonsTarget': 'dynamic_jsons_target',
        'webhookResponseField': 'webhook_response_field',
        'allowGoBack': 'allow_go_back',
        'allowRelease': 'allow_release',
        'externalMetadata': 'external_metadata',
        'cardJsonSchema': 'card_json_schema',
        'cardUiSchema': 'card_ui_schema'
      },
    );
