import 'package:json_annotation/json_annotation.dart';

enum BaseStageType {task, conditional}

@JsonSerializable()
abstract class BaseStage {
  final int id;
  final String name;
  final String? description;
  final int chain;
  final List<int> inStages;
  final List<int> outStages;
  @JsonKey(fromJson: parseStringToDouble)
  final double xPos;
  @JsonKey(fromJson: parseStringToDouble)
  final double yPos;
  final BaseStageType type;

  BaseStage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
    required this.inStages,
    required this.outStages,
    required this.xPos,
    required this.yPos,
    required this.type,
  });

  static double parseStringToDouble(String json) {
    try {
      return double.parse(json);
    } catch (e) {
      return 0;
    }
  }
}
