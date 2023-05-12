import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Chain;

part 'chain.g.dart';

@JsonSerializable(explicitToJson: true)
class Chain extends Equatable {
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

  factory Chain.fromApiModel(api.Chain model) {
    return Chain(
      id: model.id,
      name: model.name,
      description: model.description,
      campaign: model.campaign,
      stagesData: model.stagesData?.map(TaskStageChainInfo.fromApiModel).toList(),
    );
  }

  Map<String, dynamic> toJson() => _$ChainToJson(this);

  @override
  List<Object?> get props => [id, name, description, campaign, stagesData];
}
