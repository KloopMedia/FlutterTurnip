import 'package:gigaturnip_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chain.g.dart';

@JsonSerializable()
class Chain {
  final int id;
  final String name;
  final String? description;
  final int? campaign;
  final List<TaskStageChainInfo>? stagesData;

  const Chain({
    required this.id,
    required this.name,
    required this.description,
    required this.campaign,
    required this.stagesData,
  });

  factory Chain.fromJson(Map<String, dynamic> json) {
    return _$ChainFromJson(json);
  }
}
