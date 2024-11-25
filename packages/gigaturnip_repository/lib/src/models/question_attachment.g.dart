// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAttachment _$QuestionAttachmentFromJson(Map<String, dynamic> json) =>
    QuestionAttachment(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      file: json['file'] as String,
    );

Map<String, dynamic> _$QuestionAttachmentToJson(QuestionAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'file': instance.file,
    };
