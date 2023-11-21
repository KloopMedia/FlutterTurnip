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
  final String? descriptor;
  final String logo;
  final int unreadNotifications;
  final List<int>? languages;
  final List<int>? countries;
  final String? smsPhone;
  final bool smsCompleteTaskAllow;
  final bool isJoined;

  const Campaign({
    required this.id,
    required this.name,
    required this.description,
    required this.descriptor,
    required this.logo,
    required this.smsLoginAllow,
    required this.unreadNotifications,
    required this.languages,
    required this.countries,
    this.canJoin = false,
    required this.smsPhone,
    required this.smsCompleteTaskAllow,
    required this.isJoined,
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
      descriptor: model.descriptor,
      logo: model.logo,
      smsLoginAllow: model.smsLoginAllow,
      unreadNotifications: model.notificationsCount,
      languages: model.languages,
      countries: model.countries,
      smsPhone: model.smsPhone,
      smsCompleteTaskAllow: model.smsCompleteTaskAllow,
      isJoined: model.isJoined,
    );
  }

  @override
  List<Object?> get props => [id, name, description, canJoin];
}
