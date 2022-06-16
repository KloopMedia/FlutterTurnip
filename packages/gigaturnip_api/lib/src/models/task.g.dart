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
          assignee: $checkedConvert('assignee', (v) => v as int?),
          case_: $checkedConvert(
              'case_',
              (v) =>
                  v == null ? null : Case.fromJson(v as Map<String, dynamic>)),
          inTasks: $checkedConvert('in_tasks',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'forceComplete': 'force_complete',
        'inTasks': 'in_tasks'
      },
    );
