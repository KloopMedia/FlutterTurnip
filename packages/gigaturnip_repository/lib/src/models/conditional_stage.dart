import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_api/gigaturnip_api.dart' show BaseStageType;
import 'package:json_annotation/json_annotation.dart';

import '../../gigaturnip_repository.dart';

part 'conditional_stage.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ConditionalStage<T> extends BaseStage {
  final List<Map<String, dynamic>> conditions;
  final bool pingpong;

   const ConditionalStage({
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
    super.type = api.BaseStageType.conditional,
  });

  factory ConditionalStage.fromJson(json, T Function(Object? json) fromJsonT) {
    return _$ConditionalStageFromJson(json, fromJsonT);
  }

  factory ConditionalStage.fromApiModel(api.ConditionalStage model) {
    return ConditionalStage(
      id: model.id,
      name: model.name,
      description: model.description,
      chain: model.chain,
      conditions: model.conditions,
      inStages: model.inStages,
      outStages: model.outStages,
      pingpong: model.pingpong,
      xPos: model.xPos,
      yPos: model.yPos,
      type: model.type,
    );
  }
}
