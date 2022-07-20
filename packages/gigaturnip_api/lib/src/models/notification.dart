import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String text;
  final int importance;
  final int campaign;
  final int? rank;
  final int targetUser;

  Notification({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.text,
    required this.importance,
    required this.campaign,
    required this.rank,
    required this.targetUser,

  });


  factory Notification.fromJson(Map<String, dynamic> json) {
    return _$NotificationFromJson(json);
  }
}

