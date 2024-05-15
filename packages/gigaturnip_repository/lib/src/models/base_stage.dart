import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
abstract class BaseStage extends Equatable {
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

  const BaseStage({
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

  @override
  List<Object?> get props => [id, name, description, chain, inStages, outStages];
}
