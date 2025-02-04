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
      smsPhone: json['smsPhone'] as String?,
      smsCompleteTaskAllow: json['smsCompleteTaskAllow'] as bool,
      isJoined: json['isJoined'] as bool,
      featuredImage: json['featuredImage'] as String?,
      contactUsLink: json['contactUsLink'] as String?,
      newTaskViewMode: json['newTaskViewMode'] as bool? ?? false,
      registrationStage: (json['registrationStage'] as num?)?.toInt(),
      isCompleted: json['isCompleted'] as bool? ?? false,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
    );

Map<String, dynamic> _$CampaignToJson(Campaign instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'logo': instance.logo,
      'smsPhone': instance.smsPhone,
      'smsCompleteTaskAllow': instance.smsCompleteTaskAllow,
      'isJoined': instance.isJoined,
      'featuredImage': instance.featuredImage,
      'contactUsLink': instance.contactUsLink,
      'newTaskViewMode': instance.newTaskViewMode,
      'registrationStage': instance.registrationStage,
      'isCompleted': instance.isCompleted,
      'startDate': instance.startDate?.toIso8601String(),
    };
