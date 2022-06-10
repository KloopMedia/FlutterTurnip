import 'package:gigaturnip_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conditional_stage.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ConditionalStage<T> {
  final String name;
  final String description;


  final Chain chain;
  final Stage stage;

  ConditionalStage({
    required this.name,
    required this.description,


    required this.chain,
    required this.stage,


  });

  factory ConditionalStage.fromJson(json, T Function(Object? json) fromJsonT) {
    return _$ConditionalStageFromJson(json, fromJsonT);
  }
}
