// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campaign _$CampaignFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Campaign',
      json,
      ($checkedConvert) {
        final val = Campaign(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updated_at', (v) => DateTime.parse(v as String)),
          open: $checkedConvert('open', (v) => v as bool),
          defaultTrack:
              $checkedConvert('default_track', (v) => (v as num?)?.toInt()),
          managers: $checkedConvert(
              'managers',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList()),
          smsLoginAllow: $checkedConvert('sms_login_allow', (v) => v as bool),
          logo: $checkedConvert('logo', (v) => v as String),
          shortDescription:
              $checkedConvert('short_description', (v) => v as String?),
          notificationsCount:
              $checkedConvert('notifications_count', (v) => (v as num).toInt()),
          languages: $checkedConvert(
              'languages',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList()),
          countries: $checkedConvert(
              'countries',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => (e as num).toInt())
                  .toList()),
          smsPhone: $checkedConvert('sms_phone', (v) => v as String?),
          isJoined: $checkedConvert('is_joined', (v) => v as bool),
          featured: $checkedConvert('featured', (v) => v as bool),
          featuredImage: $checkedConvert('featured_image', (v) => v as String?),
          smsCompleteTaskAllow: $checkedConvert(
              'sms_complete_task_allow', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
        'defaultTrack': 'default_track',
        'smsLoginAllow': 'sms_login_allow',
        'shortDescription': 'short_description',
        'notificationsCount': 'notifications_count',
        'smsPhone': 'sms_phone',
        'isJoined': 'is_joined',
        'featuredImage': 'featured_image',
        'smsCompleteTaskAllow': 'sms_complete_task_allow'
      },
    );
