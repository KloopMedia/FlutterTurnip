// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'question_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAttachment _$QuestionAttachmentFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'QuestionAttachment',
      json,
      ($checkedConvert) {
        final val = QuestionAttachment(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          type: $checkedConvert('type', (v) => v as String),
          file: $checkedConvert('file', (v) => v as String),
        );
        return val;
      },
    );
