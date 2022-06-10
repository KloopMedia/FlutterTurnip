import 'package:gigaturnip_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conditional_stage.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ConditionalStage<T> {
  final int id;
  final String name;
  final String description;
  final Chain chain;
  final List<int> inStages;
  final int xPos;
  final int yPos;
  final int? conditions;
  final bool pinpong;

  ConditionalStage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
    required this.inStages,
    required this.xPos,
    required this.yPos,
    required this.conditions,
    required this.pinpong,

  });

  factory ConditionalStage.fromJson(json, T Function(Object? json) fromJsonT) {
    return _$ConditionalStageFromJson(json, fromJsonT);
  }
}
