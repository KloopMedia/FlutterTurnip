import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Language;

part 'language.g.dart';

@JsonSerializable()
class Language extends Equatable {
  final int id;
  final String name;
  final String code;

  const Language({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return _$LanguageFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LanguageToJson(this);
  }

  factory Language.fromApiModel(api.Language model) {
    return Language(
        id: model.id,
        name: model.name,
        code: model.code
    );
  }

  @override
  List<Object?> get props => [id, name, code];
}