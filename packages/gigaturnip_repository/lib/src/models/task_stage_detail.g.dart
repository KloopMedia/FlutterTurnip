// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_stage_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStageDetail _$TaskStageDetailFromJson(Map<String, dynamic> json) =>
    TaskStageDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      chain: (json['chain'] as num).toInt(),
      campaign: (json['campaign'] as num).toInt(),
      richText: json['richText'] as String?,
      cardJsonSchema: json['cardJsonSchema'] as Map<String, dynamic>?,
      cardUiSchema: json['cardUiSchema'] as Map<String, dynamic>?,
      jsonSchema: json['jsonSchema'] as Map<String, dynamic>?,
      uiSchema: json['uiSchema'] as Map<String, dynamic>?,
      dynamicJsonsSource: (json['dynamicJsonsSource'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      dynamicJsonsTarget: (json['dynamicJsonsTarget'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      allowRelease: json['allowRelease'] as bool,
      allowGoBack: json['allowGoBack'] as bool,
      availableTo: json['availableTo'] == null
          ? null
          : DateTime.parse(json['availableTo'] as String),
      availableFrom: json['availableFrom'] == null
          ? null
          : DateTime.parse(json['availableFrom'] as String),
      quizAnswers: json['quizAnswers'] as Map<String, dynamic>?,
      externalRendererUrl: json['externalRendererUrl'] as String?,
      openLimit: (json['openLimit'] as num?)?.toInt() ?? 0,
      totalLimit: (json['totalLimit'] as num?)?.toInt() ?? 0,
      inStages: (json['inStages'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      outStages: (json['outStages'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      xPos: BaseStage.parseStringToDouble(json['xPos'] as String),
      yPos: BaseStage.parseStringToDouble(json['yPos'] as String),
      type: $enumDecodeNullable(_$BaseStageTypeEnumMap, json['type']) ??
          api.BaseStageType.task,
    );

Map<String, dynamic> _$TaskStageDetailToJson(TaskStageDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'chain': instance.chain,
      'inStages': instance.inStages,
      'outStages': instance.outStages,
      'xPos': instance.xPos,
      'yPos': instance.yPos,
      'type': _$BaseStageTypeEnumMap[instance.type]!,
      'campaign': instance.campaign,
      'richText': instance.richText,
      'cardJsonSchema': instance.cardJsonSchema,
      'cardUiSchema': instance.cardUiSchema,
      'jsonSchema': instance.jsonSchema,
      'uiSchema': instance.uiSchema,
      'dynamicJsonsSource': instance.dynamicJsonsSource,
      'dynamicJsonsTarget': instance.dynamicJsonsTarget,
      'allowRelease': instance.allowRelease,
      'allowGoBack': instance.allowGoBack,
      'availableTo': instance.availableTo?.toIso8601String(),
      'availableFrom': instance.availableFrom?.toIso8601String(),
      'openLimit': instance.openLimit,
      'totalLimit': instance.totalLimit,
      'quizAnswers': instance.quizAnswers,
      'externalRendererUrl': instance.externalRendererUrl,
    };

const _$BaseStageTypeEnumMap = {
  BaseStageType.task: 'task',
  BaseStageType.conditional: 'conditional',
};
