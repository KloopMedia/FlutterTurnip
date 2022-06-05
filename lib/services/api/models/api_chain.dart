import 'package:flutter/foundation.dart' show immutable;

@immutable
class ApiChain {
  final int id;
  final String name;
  final String description;
  final int campaign;

  const ApiChain({
    required this.id,
    required this.name,
    required this.description,
    required this.campaign,
  });

  factory ApiChain.fromJson(Map<String, dynamic> json) {
    return ApiChain(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      campaign: json['campaign'],
    );
  }
}
