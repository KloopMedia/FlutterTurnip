import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Campaign;

part 'campaign.g.dart';

@JsonSerializable()
class Campaign extends Equatable {
  final int id;
  final String name;
  final String description;

  const Campaign({required this.id, required this.name, required this.description});

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return _$CampaignFromJson(json);
  }

  factory Campaign.fromApiModel(api.Campaign model) {
    return Campaign(
      id: model.id,
      name: model.name,
      description: model.description,
    );
  }

  @override
  List<Object?> get props => [id, name, description];
}
