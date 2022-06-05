// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiCampaign _$ApiCampaignFromJson(Map<String, dynamic> json) => ApiCampaign(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ApiCampaignToJson(ApiCampaign instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
