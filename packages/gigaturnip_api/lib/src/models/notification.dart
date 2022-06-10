import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final int id;
  final String name;
  final String description;


  Notification({
    required this.id,
    required this.name,
    required this.description,
  });


  factory Notification.fromJson(Map<String, dynamic> json) {
    return _$NotificationFromJson(json);
  }
}

