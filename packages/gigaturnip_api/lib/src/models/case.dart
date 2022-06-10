import 'package:json_annotation/json_annotation.dart';

part 'case.g.dart';

@JsonSerializable()
class Case {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;


  Case({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });


  factory Case.fromJson(Map<String, dynamic> json) {
    return _$CaseFromJson(json);
  }
}
