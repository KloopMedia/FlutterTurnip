// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) => Test(
      id: (json['id'] as num).toInt(),
      stage: (json['stage'] as num).toInt(),
      questionLimit: (json['questionLimit'] as num).toInt(),
      passingScore: (json['passingScore'] as num).toInt(),
      orderBy: json['orderBy'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'id': instance.id,
      'stage': instance.stage,
      'questionLimit': instance.questionLimit,
      'passingScore': instance.passingScore,
      'orderBy': instance.orderBy,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };
