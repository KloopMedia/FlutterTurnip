// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      importance: json['importance'] as int,
      senderTask: json['senderTask'] as int?,
      receiverTask: json['receiverTask'] as int?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'importance': instance.importance,
      'senderTask': instance.senderTask,
      'receiverTask': instance.receiverTask,
    };
