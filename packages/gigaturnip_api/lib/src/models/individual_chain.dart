import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'individual_chain.g.dart';

@JsonSerializable()
class IndividualChain {
  final int id;
  final String name;
  final List<TaskStageChainInfo> stagesData;

  const IndividualChain({required this.id, required this.name, required this.stagesData});

  factory IndividualChain.fromJson(Map<String, dynamic> json) {
    return _$IndividualChainFromJson(json);
  }
}
