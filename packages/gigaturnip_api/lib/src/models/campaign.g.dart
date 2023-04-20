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
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updated_at', (v) => DateTime.parse(v as String)),
          open: $checkedConvert('open', (v) => v as bool),
          defaultTrack: $checkedConvert('default_track', (v) => v as int?),
          managers: $checkedConvert('managers',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          smsLoginAllow: $checkedConvert('sms_login_allow', (v) => v as bool),
          logo: $checkedConvert('logo', (v) => v as String),
          descriptor: $checkedConvert('descriptor', (v) => v as String?),
          notificationsCount:
              $checkedConvert('notifications_count', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
        'defaultTrack': 'default_track',
        'smsLoginAllow': 'sms_login_allow',
        'notificationsCount': 'notifications_count'
      },
    );
