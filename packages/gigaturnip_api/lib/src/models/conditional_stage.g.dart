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
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          chain: $checkedConvert(
              'chain', (v) => Chain.fromJson(v as Map<String, dynamic>)),
          stage: $checkedConvert(
              'stage', (v) => Stage.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );
