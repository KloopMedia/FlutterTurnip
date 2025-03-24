// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chain _$ChainFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Chain',
      json,
      ($checkedConvert) {
        final val = Chain(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          campaign: $checkedConvert('campaign', (v) => (v as num).toInt()),
          newTaskViewMode:
              $checkedConvert('new_task_view_mode', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {'newTaskViewMode': 'new_task_view_mode'},
    );
