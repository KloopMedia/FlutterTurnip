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
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
          chain: $checkedConvert('chain', (v) => (v as num).toInt()),
          xPos: $checkedConvert(
              'x_pos', (v) => BaseStage.parseStringToDouble(v as String)),
          yPos: $checkedConvert(
              'y_pos', (v) => BaseStage.parseStringToDouble(v as String)),
          campaign: $checkedConvert('campaign', (v) => (v as num).toInt()),
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
          availableTo: $checkedConvert('available_to',
              (v) => v == null ? null : DateTime.parse(v as String)),
          availableFrom: $checkedConvert('available_from',
              (v) => v == null ? null : DateTime.parse(v as String)),
          filterFieldsSchema: $checkedConvert(
              'filter_fields_schema',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => e as Map<String, dynamic>)
                  .toList()),
          quizAnswers: $checkedConvert(
              'quiz_answers', (v) => v as Map<String, dynamic>?),
          rankLimit:
              $checkedConvert('rank_limit', (v) => v as Map<String, dynamic>?),
          externalRendererUrl:
              $checkedConvert('external_renderer_url', (v) => v as String?),
          inStages: $checkedConvert(
              'in_stages',
              (v) =>
                  (v as List<dynamic>).map((e) => (e as num).toInt()).toList()),
          outStages: $checkedConvert(
              'out_stages',
              (v) =>
                  (v as List<dynamic>).map((e) => (e as num).toInt()).toList()),
          type: $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$BaseStageTypeEnumMap, v) ??
                  BaseStageType.task),
        );
        return val;
      },
      fieldKeyMap: const {
        'xPos': 'x_pos',
        'yPos': 'y_pos',
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
        'cardUiSchema': 'card_ui_schema',
        'availableTo': 'available_to',
        'availableFrom': 'available_from',
        'filterFieldsSchema': 'filter_fields_schema',
        'quizAnswers': 'quiz_answers',
        'rankLimit': 'rank_limit',
        'externalRendererUrl': 'external_renderer_url',
        'inStages': 'in_stages',
        'outStages': 'out_stages'
      },
    );

const _$BaseStageTypeEnumMap = {
  BaseStageType.task: 'task',
  BaseStageType.conditional: 'conditional',
};
