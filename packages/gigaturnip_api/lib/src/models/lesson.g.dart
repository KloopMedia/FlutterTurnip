// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Lesson',
      json,
      ($checkedConvert) {
        final val = Lesson(
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          richText: $checkedConvert('rich_text', (v) => v as String),
          test: $checkedConvert(
              'test',
              (v) =>
                  v == null ? null : Test.fromJson(v as Map<String, dynamic>)),
          inStages: $checkedConvert(
              'in_stages',
              (v) =>
                  (v as List<dynamic>).map((e) => (e as num).toInt()).toList()),
          outStages: $checkedConvert(
              'out_stages',
              (v) =>
                  (v as List<dynamic>).map((e) => (e as num).toInt()).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'richText': 'rich_text',
        'inStages': 'in_stages',
        'outStages': 'out_stages'
      },
    );
