// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'create_task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTaskResponse _$CreateTaskResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CreateTaskResponse',
      json,
      ($checkedConvert) {
        final val = CreateTaskResponse(
          status: $checkedConvert('status', (v) => v as String? ?? ""),
          id: $checkedConvert('id', (v) => v as int),
        );
        return val;
      },
    );
