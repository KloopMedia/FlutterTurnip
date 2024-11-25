// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: (json['id'] as num).toInt(),
      index: (json['index'] as num).toInt(),
      title: json['title'] as String?,
      jsonSchema: json['jsonSchema'] as Map<String, dynamic>?,
      uiSchema: json['uiSchema'] as Map<String, dynamic>?,
      correctAnswer: json['correctAnswer'] as Map<String, dynamic>?,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => QuestionAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'title': instance.title,
      'jsonSchema': instance.jsonSchema,
      'uiSchema': instance.uiSchema,
      'correctAnswer': instance.correctAnswer,
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
    };
