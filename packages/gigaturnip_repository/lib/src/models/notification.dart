import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Notification;
part 'notification.g.dart';

@JsonSerializable()
class Notifications extends Equatable {
  final int id;
  final String title;
  final String text;
  final DateTime createdAt;
  final int importance;

  const Notifications({
    required this.id,
    required this.title,
    required this.text,
    required this.createdAt,
    required this.importance,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return _$NotificationFromJson(json);
  }

  factory Notifications.fromApiModel(api.Notification model) {
    return Notifications(
      id: model.id,
      title: model.title,
      text: model.text,
      createdAt: model.createdAt,
      importance: model.importance
    );
  }

  @override
  List<Object?> get props => [id, title, text, createdAt, importance];

}