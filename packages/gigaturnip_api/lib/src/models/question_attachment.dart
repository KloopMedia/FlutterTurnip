import 'package:json_annotation/json_annotation.dart';

part 'question_attachment.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionAttachment {
  final int id;
  final String type;
  final String file;

  QuestionAttachment({
    required this.id,
    required this.type,
    required this.file,
  });

  factory QuestionAttachment.fromJson(Map<String, dynamic> json) => _$QuestionAttachmentFromJson(json);
}