import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Notification;

part 'notification.g.dart';

@JsonSerializable()
class Notification extends Equatable {
  final int id;
  final String title;
  final String text;
  final DateTime createdAt;
  final int importance;
  final int? senderTask;
  final int? receiverTask;

  const Notification({
    required this.id,
    required this.title,
    required this.text,
    required this.createdAt,
    required this.importance,
    required this.senderTask,
    required this.receiverTask,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return _$NotificationFromJson(json);
  }

  factory Notification.fromApiModel(api.Notification model) {
    return Notification(
      id: model.id,
      title: model.title,
      text: model.text,
      createdAt: model.createdAt,
      importance: model.importance,
      senderTask: model.senderTask,
      receiverTask: model.receiverTask,
    );
  }

  @override
  List<Object?> get props => [id, title, text, createdAt, importance, senderTask, receiverTask];
}
