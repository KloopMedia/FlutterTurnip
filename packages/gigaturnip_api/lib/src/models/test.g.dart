// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Test',
      json,
      ($checkedConvert) {
        final val = Test(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          stage: $checkedConvert('stage', (v) => (v as num).toInt()),
          questionLimit:
              $checkedConvert('question_limit', (v) => (v as num).toInt()),
          passingScore:
              $checkedConvert('passing_score', (v) => (v as num).toInt()),
          orderBy: $checkedConvert('order_by', (v) => v as String),
          questions: $checkedConvert(
              'questions',
              (v) => (v as List<dynamic>)
                  .map((e) => Question.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'questionLimit': 'question_limit',
        'passingScore': 'passing_score',
        'orderBy': 'order_by'
      },
    );
