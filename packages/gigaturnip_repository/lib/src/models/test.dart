import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
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

  factory Test.fromApiModel(api.Test model) {
    return Test(
      id: model.id,
      stage: model.stage,
      questionLimit: model.questionLimit,
      passingScore: model.passingScore,
      orderBy: model.orderBy,
      questions: model.questions.map(Question.fromApiModel).toList(),
    );
  }

  Map<String, dynamic> toJson() => _$TestToJson(this);
}