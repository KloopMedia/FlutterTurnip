// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stage _$StageFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Stage',
      json,
      ($checkedConvert) {
        final val = Stage(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          chain: $checkedConvert(
              'chain', (v) => Chain.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );
