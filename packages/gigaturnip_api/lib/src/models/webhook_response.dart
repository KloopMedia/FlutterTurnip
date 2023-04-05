import 'package:json_annotation/json_annotation.dart';

part 'webhook_response.g.dart';

@JsonSerializable()
class WebhookResponse {
  final String status;
  final Map<String, dynamic> responses;

  WebhookResponse({required this.status, required this.responses});

  factory WebhookResponse.fromJson(Map<String, dynamic> json) {
    return _$WebhookResponseFromJson(json);
  }
}
