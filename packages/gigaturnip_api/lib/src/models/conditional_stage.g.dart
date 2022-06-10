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
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          chain: $checkedConvert(
              'chain', (v) => Chain.fromJson(v as Map<String, dynamic>)),
          inStages: $checkedConvert('in_stages',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          xPos: $checkedConvert('x_pos', (v) => v as int),
          yPos: $checkedConvert('y_pos', (v) => v as int),
          conditions: $checkedConvert('conditions', (v) => v as int?),
          pinpong: $checkedConvert('pinpong', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'inStages': 'in_stages',
        'xPos': 'x_pos',
        'yPos': 'y_pos'
      },
    );
