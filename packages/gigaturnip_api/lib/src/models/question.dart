import 'package:json_annotation/json_annotation.dart';

import 'question_attachment.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  final int id;
  final int index;
  final String? title;
  final Map<String, dynamic>? jsonSchema;
  final Map<String, dynamic>? uiSchema;
  final Map<String, dynamic>? correctAnswer;
  final List<QuestionAttachment> attachments;

  Question({
    required this.id,
    required this.index,
    this.title,
    this.jsonSchema,
    this.uiSchema,
    this.correctAnswer,
    required this.attachments,
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}