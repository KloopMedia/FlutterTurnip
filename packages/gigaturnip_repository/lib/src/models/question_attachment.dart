import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
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

  factory QuestionAttachment.fromJson(Map<String, dynamic> json) =>
      _$QuestionAttachmentFromJson(json);

  factory QuestionAttachment.fromApiModel(api.QuestionAttachment model) {
    return QuestionAttachment(id: model.id, type: model.type, file: model.file);
  }

  Map<String, dynamic> toJson() => _$QuestionAttachmentToJson(this);
}
