import 'package:gigaturnip_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conditional_stage.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ConditionalStage<T> extends BaseStage {
  final List<Map<String, dynamic>> conditions;
  final bool pingpong;

  ConditionalStage({
    required super.id,
    required super.name,
    required super.description,
    required super.chain,
    required super.inStages,
    required super.outStages,
    required super.xPos,
    required super.yPos,
    required this.conditions,
    required this.pingpong,
    super.type = BaseStageType.conditional,
  });

  factory ConditionalStage.fromJson(json, T Function(Object? json) fromJsonT) {
    return _$ConditionalStageFromJson(json, fromJsonT);
  }
}
