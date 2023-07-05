// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campaign _$CampaignFromJson(Map<String, dynamic> json) => Campaign(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      descriptor: json['descriptor'] as String?,
      logo: json['logo'] as String,
      smsLoginAllow: json['smsLoginAllow'] as bool,
      unreadNotifications: json['unreadNotifications'] as int,
      languages:
          (json['languages'] as List<dynamic>?)?.map((e) => e as int).toList(),
      canJoin: json['canJoin'] as bool? ?? false,
    );

Map<String, dynamic> _$CampaignToJson(Campaign instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'canJoin': instance.canJoin,
      'smsLoginAllow': instance.smsLoginAllow,
      'descriptor': instance.descriptor,
      'logo': instance.logo,
      'unreadNotifications': instance.unreadNotifications,
      'languages': instance.languages,
    };
