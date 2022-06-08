import 'package:gigaturnip_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stage.g.dart';

@JsonSerializable()
class Stage {
  final int id;
  final String name;
  final String description;
  final Chain chain;

  const Stage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return _$StageFromJson(json);
  }
}
