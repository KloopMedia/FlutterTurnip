import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Campaign;
import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool canJoin;
  final bool smsLoginAllow;
  final String? shortDescription;
  final String logo;
  final int unreadNotifications;
  final List<int>? languages;
  final List<int>? countries;
  final String? smsPhone;
  final bool smsCompleteTaskAllow;
  final bool isJoined;
  final bool featured;
  final String? featuredImage;
  final String? contactUsLink;
  final bool newTaskViewMode;
  final int? defaultTrack;

  const Campaign({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.logo,
    required this.smsLoginAllow,
    required this.unreadNotifications,
    required this.languages,
    required this.countries,
    this.canJoin = false,
    required this.smsPhone,
    required this.smsCompleteTaskAllow,
    required this.isJoined,
    required this.featured,
    required this.featuredImage,
    required this.contactUsLink,
    this.newTaskViewMode = false,
    required this.defaultTrack,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return _$CampaignFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CampaignToJson(this);
  }

  factory Campaign.fromApiModel(api.Campaign model, bool canJoin) {
    return Campaign(
      id: model.id,
      name: model.name,
      description: model.description,
      canJoin: canJoin,
      shortDescription: model.shortDescription,
      logo: model.logo,
      smsLoginAllow: model.smsLoginAllow,
      unreadNotifications: model.notificationsCount,
      languages: model.languages,
      countries: model.countries,
      smsPhone: model.smsPhone,
      smsCompleteTaskAllow: model.smsCompleteTaskAllow,
      isJoined: model.isJoined,
      featured: model.featured,
      featuredImage: model.featuredImage,
      contactUsLink: model.contactUsLink,
      newTaskViewMode: model.newTaskViewMode,
      defaultTrack: model.defaultTrack,
    );
  }

  @override
  List<Object?> get props => [id, name, description, canJoin];
}
