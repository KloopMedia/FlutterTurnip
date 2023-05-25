import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show IndividualChain;

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

  factory IndividualChain.fromApiModel(api.IndividualChain model) {
    return IndividualChain(
      id: model.id,
      name: model.name,
      stagesData: model.stagesData.map((e) => TaskStageChainInfo.fromApiModel(e)).toList(),
    );
  }
}
