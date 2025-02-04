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
          logo: $checkedConvert('logo', (v) => v as String),
          smsPhone: $checkedConvert('sms_phone', (v) => v as String?),
          isJoined: $checkedConvert('is_joined', (v) => v as bool),
          featuredImage: $checkedConvert('featured_image', (v) => v as String?),
          smsCompleteTaskAllow: $checkedConvert(
              'sms_complete_task_allow', (v) => v as bool? ?? false),
          contactUsLink:
              $checkedConvert('contact_us_link', (v) => v as String?),
          newTaskViewMode:
              $checkedConvert('new_task_view_mode', (v) => v as bool? ?? false),
          registrationStage: $checkedConvert(
              'registration_stage', (v) => (v as num?)?.toInt()),
          isCompleted:
              $checkedConvert('is_completed', (v) => v as bool? ?? false),
          startDate: $checkedConvert('start_date',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'smsPhone': 'sms_phone',
        'isJoined': 'is_joined',
        'featuredImage': 'featured_image',
        'smsCompleteTaskAllow': 'sms_complete_task_allow',
        'contactUsLink': 'contact_us_link',
        'newTaskViewMode': 'new_task_view_mode',
        'registrationStage': 'registration_stage',
        'isCompleted': 'is_completed',
        'startDate': 'start_date'
      },
    );
