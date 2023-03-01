// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'dynamic_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicSchema _$DynamicSchemaFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DynamicSchema',
      json,
      ($checkedConvert) {
        final val = DynamicSchema(
          status: $checkedConvert('status', (v) => v as int),
          schema: $checkedConvert('schema', (v) => v as Map<String, dynamic>),
        );
        return val;
      },
    );
