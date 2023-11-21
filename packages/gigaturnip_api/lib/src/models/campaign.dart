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
  final List<int>? managers;
  final bool smsLoginAllow;
  final String? descriptor;
  final String logo;
  final int notificationsCount;
  final List<int>? languages;
  final List<int>? countries;
  final String? smsPhone;
  final bool smsCompleteTaskAllow;
  final bool isJoined;

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
    required this.notificationsCount,
    required this.languages,
    required this.countries,
    required this.smsPhone,
    required this.isJoined,
    this.smsCompleteTaskAllow = false,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return _$CampaignFromJson(json);
  }
}
