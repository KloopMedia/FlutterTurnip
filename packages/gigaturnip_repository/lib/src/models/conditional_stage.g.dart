// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conditional_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConditionalStage<T> _$ConditionalStageFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ConditionalStage<T>(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      chain: (json['chain'] as num).toInt(),
      inStages: (json['inStages'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      outStages: (json['outStages'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      xPos: BaseStage.parseStringToDouble(json['xPos'] as String),
      yPos: BaseStage.parseStringToDouble(json['yPos'] as String),
      conditions: (json['conditions'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      pingpong: json['pingpong'] as bool,
      type: $enumDecodeNullable(_$BaseStageTypeEnumMap, json['type']) ??
          api.BaseStageType.conditional,
    );

Map<String, dynamic> _$ConditionalStageToJson<T>(
  ConditionalStage<T> instance,
  Object? Function(T value) toJsonT,
) =>
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
      'conditions': instance.conditions,
      'pingpong': instance.pingpong,
    };

const _$BaseStageTypeEnumMap = {
  BaseStageType.task: 'task',
  BaseStageType.conditional: 'conditional',
};
