// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campaign _$CampaignFromJson(Map<String, dynamic> json) => Campaign(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      shortDescription: json['shortDescription'] as String?,
      logo: json['logo'] as String,
      smsLoginAllow: json['smsLoginAllow'] as bool,
      unreadNotifications: (json['unreadNotifications'] as num).toInt(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      canJoin: json['canJoin'] as bool? ?? false,
      smsPhone: json['smsPhone'] as String?,
      smsCompleteTaskAllow: json['smsCompleteTaskAllow'] as bool,
      isJoined: json['isJoined'] as bool,
      featured: json['featured'] as bool,
      featuredImage: json['featuredImage'] as String?,
      contactUsLink: json['contactUsLink'] as String?,
      newTaskViewMode: json['newTaskViewMode'] as bool,
      defaultTrack: (json['defaultTrack'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CampaignToJson(Campaign instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'canJoin': instance.canJoin,
      'smsLoginAllow': instance.smsLoginAllow,
      'shortDescription': instance.shortDescription,
      'logo': instance.logo,
      'unreadNotifications': instance.unreadNotifications,
      'languages': instance.languages,
      'countries': instance.countries,
      'smsPhone': instance.smsPhone,
      'smsCompleteTaskAllow': instance.smsCompleteTaskAllow,
      'isJoined': instance.isJoined,
      'featured': instance.featured,
      'featuredImage': instance.featuredImage,
      'contactUsLink': instance.contactUsLink,
      'newTaskViewMode': instance.newTaskViewMode,
      'defaultTrack': instance.defaultTrack,
    };
