import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:json_annotation/json_annotation.dart';

part 'question_attachment.g.dart';

enum QuestionAttachmentType {
  audio,
  image,
  video,
  other,
}

@JsonSerializable(explicitToJson: true)
class QuestionAttachment {
  final int id;
  @JsonKey(
    fromJson: _stringToType,
    toJson: _stringFromType,
  )
  final QuestionAttachmentType type;
  final String file;

  QuestionAttachment({
    required this.id,
    required this.type,
    required this.file,
  });

  factory QuestionAttachment.fromJson(Map<String, dynamic> json) =>
      _$QuestionAttachmentFromJson(json);

  factory QuestionAttachment.fromApiModel(api.QuestionAttachment model) {
    return QuestionAttachment(id: model.id, type: typeFromJson(model.type), file: model.file);
  }

  Map<String, dynamic> toJson() => _$QuestionAttachmentToJson(this);

  static QuestionAttachmentType _stringToType(String json) => typeFromJson(json);

  static String _stringFromType(QuestionAttachmentType json) => typeToJson(json);

  static QuestionAttachmentType typeFromJson(String value) {
    switch (value) {
      case 'AUDIO':
        return QuestionAttachmentType.audio;
      case 'IMAGE':
        return QuestionAttachmentType.image;
      case 'VIDEO':
        return QuestionAttachmentType.video;
      case 'OTHER':
        return QuestionAttachmentType.other;
      default:
        throw ArgumentError('Invalid QuestionAttachmentType: $value');
    }
  }

  static String typeToJson(QuestionAttachmentType type) {
    switch (type) {
      case QuestionAttachmentType.audio:
        return 'AUDIO';
      case QuestionAttachmentType.image:
        return 'IMAGE';
      case QuestionAttachmentType.video:
        return 'VIDEO';
      case QuestionAttachmentType.other:
        return 'OTHER';
    }
  }
}
