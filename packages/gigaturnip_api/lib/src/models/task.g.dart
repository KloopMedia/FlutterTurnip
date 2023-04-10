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
          reopened: $checkedConvert('reopened', (v) => v as bool?),
          forceComplete: $checkedConvert('force_complete', (v) => v as bool?),
          stage: $checkedConvert(
              'stage', (v) => TaskStage.fromJson(v as Map<String, dynamic>)),
          createdAt: $checkedConvert('created_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'forceComplete': 'force_complete',
        'createdAt': 'created_at'
      },
    );
