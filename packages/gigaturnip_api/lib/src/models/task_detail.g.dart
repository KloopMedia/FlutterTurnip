// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDetail _$TaskDetailFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TaskDetail',
      json,
      ($checkedConvert) {
        final val = TaskDetail(
          id: $checkedConvert('id', (v) => v as int),
          responses:
              $checkedConvert('responses', (v) => v as Map<String, dynamic>?),
          complete: $checkedConvert('complete', (v) => v as bool),
          reopened: $checkedConvert('reopened', (v) => v as bool?),
          forceComplete: $checkedConvert('force_complete', (v) => v as bool?),
          stage: $checkedConvert('stage',
              (v) => TaskStageDetail.fromJson(v as Map<String, dynamic>)),
          assignee: $checkedConvert('assignee', (v) => v as int?),
          case_: $checkedConvert(
              'case_',
              (v) =>
                  v == null ? null : Case.fromJson(v as Map<String, dynamic>)),
          inTasks: $checkedConvert('in_tasks',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          createdAt: $checkedConvert('created_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          updatedAt: $checkedConvert('updated_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          displayedPrevTasks: $checkedConvert('displayed_prev_tasks',
              (v) => (v as List<dynamic>?)?.map((e) => e as int).toList()),
          integratorGroup: $checkedConvert(
              'integrator_group', (v) => v as Map<String, dynamic>?),
          startPeriod: $checkedConvert('start_period',
              (v) => v == null ? null : DateTime.parse(v as String)),
          endPeriod: $checkedConvert('end_period',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'forceComplete': 'force_complete',
        'inTasks': 'in_tasks',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
        'displayedPrevTasks': 'displayed_prev_tasks',
        'integratorGroup': 'integrator_group',
        'startPeriod': 'start_period',
        'endPeriod': 'end_period'
      },
    );
