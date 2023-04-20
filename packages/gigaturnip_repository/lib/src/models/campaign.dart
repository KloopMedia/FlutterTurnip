import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Campaign;

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

  const Campaign({
    required this.id,
    required this.name,
    required this.description,
    required this.descriptor,
    required this.logo,
    required this.smsLoginAllow,
    required this.unreadNotifications,
    this.canJoin = false,
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
    );
  }

  @override
  List<Object?> get props => [id, name, description, canJoin];
}
