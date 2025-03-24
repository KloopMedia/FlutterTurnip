import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign {
  final int id;
  final String name;
  final String description;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final bool open;
  // final int? defaultTrack;
  // final List<int>? managers;
  // final bool smsLoginAllow;
  final String? shortDescription;
  final String logo;
  // final int notificationsCount;
  // final List<int>? languages;
  // final List<int>? countries;
  final String? smsPhone;
  final bool smsCompleteTaskAllow;
  final bool isJoined;
  // final bool featured;
  final String? featuredImage;
  final String? contactUsLink;
  final int? registrationStage;
  final bool isCompleted;
  final DateTime? startDate;

  Campaign({
    required this.id,
    required this.name,
    required this.description,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.open,
    // required this.defaultTrack,
    // required this.managers,
    // required this.smsLoginAllow,
    required this.logo,
    required this.shortDescription,
    // required this.notificationsCount,
    // required this.languages,
    // required this.countries,
    required this.smsPhone,
    required this.isJoined,
    // required this.featured,
    required this.featuredImage,
    this.smsCompleteTaskAllow = false,
    required this.contactUsLink,
    required this.registrationStage,
    this.isCompleted = false,
    this.startDate
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return _$CampaignFromJson(json);
  }
}
