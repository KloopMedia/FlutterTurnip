// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TaskResponse',
      json,
      ($checkedConvert) {
        final val = TaskResponse(
          message: $checkedConvert('message', (v) => v as String? ?? ""),
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          nextDirectId:
              $checkedConvert('next_direct_id', (v) => (v as num?)?.toInt()),
          notifications:
              $checkedConvert('notifications', (v) => v as List<dynamic>?),
        );
        return val;
      },
      fieldKeyMap: const {'nextDirectId': 'next_direct_id'},
    );
