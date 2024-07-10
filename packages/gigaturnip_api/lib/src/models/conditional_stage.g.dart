// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'conditional_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConditionalStage<T> _$ConditionalStageFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    $checkedCreate(
      'ConditionalStage',
      json,
      ($checkedConvert) {
        final val = ConditionalStage<T>(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
          chain: $checkedConvert('chain', (v) => (v as num).toInt()),
          inStages: $checkedConvert(
              'in_stages',
              (v) =>
                  (v as List<dynamic>).map((e) => (e as num).toInt()).toList()),
          outStages: $checkedConvert(
              'out_stages',
              (v) =>
                  (v as List<dynamic>).map((e) => (e as num).toInt()).toList()),
          xPos: $checkedConvert(
              'x_pos', (v) => BaseStage.parseStringToDouble(v as String)),
          yPos: $checkedConvert(
              'y_pos', (v) => BaseStage.parseStringToDouble(v as String)),
          conditions: $checkedConvert(
              'conditions',
              (v) => (v as List<dynamic>)
                  .map((e) => e as Map<String, dynamic>)
                  .toList()),
          pingpong: $checkedConvert('pingpong', (v) => v as bool),
          type: $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$BaseStageTypeEnumMap, v) ??
                  BaseStageType.conditional),
        );
        return val;
      },
      fieldKeyMap: const {
        'inStages': 'in_stages',
        'outStages': 'out_stages',
        'xPos': 'x_pos',
        'yPos': 'y_pos'
      },
    );

const _$BaseStageTypeEnumMap = {
  BaseStageType.task: 'task',
  BaseStageType.conditional: 'conditional',
};
