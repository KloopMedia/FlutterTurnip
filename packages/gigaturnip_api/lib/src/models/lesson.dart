import 'package:json_annotation/json_annotation.dart';

import 'test.dart';

part 'lesson.g.dart';

@JsonSerializable(explicitToJson: true)
class Lesson {
  final String name;
  final String description;
  final String richText;
  final Test? test;
  final List<int> inStages;
  final List<int> outStages;

  Lesson({
    required this.name,
    required this.description,
    required this.richText,
    required this.test,
    required this.inStages,
    required this.outStages,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}
