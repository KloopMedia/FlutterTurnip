import 'package:json_annotation/json_annotation.dart';

part 'api_campaign.g.dart';

@JsonSerializable()
class ApiCampaign {
  final int id;
  final String name;
  final String description;

  ApiCampaign({required this.id, required this.name, required this.description});

  factory ApiCampaign.fromJson(Map<String, dynamic> json) {
    return _$ApiCampaignFromJson(json);
  }
}
