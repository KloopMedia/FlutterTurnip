// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'volume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Volume _$VolumeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Volume',
      json,
      ($checkedConvert) {
        final val = Volume(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updated_at', (v) => DateTime.parse(v as String)),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          order: $checkedConvert('order', (v) => (v as num).toInt()),
          notYetOpenMessage:
              $checkedConvert('not_yet_open_message', (v) => v as String),
          alreadyClosedMessage:
              $checkedConvert('already_closed_message', (v) => v as String),
          showTags: $checkedConvert('show_tags', (v) => v as bool),
          showTagsFilter: $checkedConvert('show_tags_filter', (v) => v as bool),
          myTasksText: $checkedConvert('my_tasks_text', (v) => v as String),
          activeTasksText:
              $checkedConvert('active_tasks_text', (v) => v as String),
          returnedTasksText:
              $checkedConvert('returned_tasks_text', (v) => v as String),
          completedTasksText:
              $checkedConvert('completed_tasks_text', (v) => v as String),
          trackFk: $checkedConvert('track_fk', (v) => (v as num).toInt()),
          openingRanks: $checkedConvert(
              'opening_ranks',
              (v) =>
                  (v as List<dynamic>).map((e) => (e as num).toInt()).toList()),
          closingRanks: $checkedConvert(
              'closing_ranks',
              (v) =>
                  (v as List<dynamic>).map((e) => (e as num).toInt()).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
        'notYetOpenMessage': 'not_yet_open_message',
        'alreadyClosedMessage': 'already_closed_message',
        'showTags': 'show_tags',
        'showTagsFilter': 'show_tags_filter',
        'myTasksText': 'my_tasks_text',
        'activeTasksText': 'active_tasks_text',
        'returnedTasksText': 'returned_tasks_text',
        'completedTasksText': 'completed_tasks_text',
        'trackFk': 'track_fk',
        'openingRanks': 'opening_ranks',
        'closingRanks': 'closing_ranks'
      },
    );
