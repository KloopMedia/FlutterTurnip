// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'Notification',
      json,
      ($checkedConvert) {
        final val = Notification(
          id: $checkedConvert('id', (v) => v as int),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updated_at', (v) => DateTime.parse(v as String)),
          title: $checkedConvert('title', (v) => v as String),
          text: $checkedConvert('text', (v) => v as String),
          importance: $checkedConvert('importance', (v) => v as int),
          campaign: $checkedConvert('campaign', (v) => v as int),
          rank: $checkedConvert('rank', (v) => v as int?),
          targetUser: $checkedConvert('target_user', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
        'targetUser': 'target_user'
      },
    );
