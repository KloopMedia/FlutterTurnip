// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Task',
      json,
      ($checkedConvert) {
        final val = Task(
          id: $checkedConvert('id', (v) => v as int),
          responses:
              $checkedConvert('responses', (v) => v as Map<String, dynamic>?),
          complete: $checkedConvert('complete', (v) => v as bool),
          reopened: $checkedConvert('reopened', (v) => v as bool),
          stage: $checkedConvert(
              'stage', (v) => Stage.fromJson(v as Map<String, dynamic>)),
          assignee: $checkedConvert('assignee', (v) => v as int?),
        );
        return val;
      },
    );
