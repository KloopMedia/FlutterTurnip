// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Question',
      json,
      ($checkedConvert) {
        final val = Question(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          index: $checkedConvert('index', (v) => (v as num).toInt()),
          title: $checkedConvert('title', (v) => v as String?),
          jsonSchema:
              $checkedConvert('json_schema', (v) => v as Map<String, dynamic>?),
          uiSchema:
              $checkedConvert('ui_schema', (v) => v as Map<String, dynamic>?),
          correctAnswer: $checkedConvert(
              'correct_answer', (v) => v as Map<String, dynamic>?),
          attachments: $checkedConvert(
              'attachments',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      QuestionAttachment.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'jsonSchema': 'json_schema',
        'uiSchema': 'ui_schema',
        'correctAnswer': 'correct_answer'
      },
    );
