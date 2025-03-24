import 'package:json_annotation/json_annotation.dart';

import 'question.dart';

part 'test.g.dart';

@JsonSerializable(explicitToJson: true)
class Test {
  final int id;
  final int stage;
  final int questionLimit;
  final int passingScore;
  final String orderBy;
  final List<Question> questions;

  Test({
    required this.id,
    required this.stage,
    required this.questionLimit,
    required this.passingScore,
    required this.orderBy,
    required this.questions,
  });

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
}