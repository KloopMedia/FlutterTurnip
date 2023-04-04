import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool open;
  final int? defaultTrack;
  final List<int> managers;
  final bool smsLoginAllow;
  final String? descriptor;
  final String logo;

  Campaign({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.open,
    required this.defaultTrack,
    required this.managers,
    required this.smsLoginAllow,
    required this.logo,
    required this.descriptor,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return _$CampaignFromJson(json);
  }
}
