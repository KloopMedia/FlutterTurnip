// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    Notifications(
      id: json['id'] as int,
      receiverTask: json['receiverTask'] as int?,
      senderTask: json['senderTask'] as int?,
      title: json['title'] as String,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      importance: json['importance'] as int,
    );

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'id': instance.id,
      'receiverTask': instance.receiverTask,
      'senderTask': instance.senderTask,
      'title': instance.title,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'importance': instance.importance,
    };
