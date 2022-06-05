import 'package:flutter/foundation.dart' show immutable;
import 'package:gigaturnip/services/api/models/api_chain.dart';

@immutable
class ApiStage {
  final int id;
  final String name;
  final String description;
  final ApiChain chain;

  const ApiStage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
  });

  factory ApiStage.fromJson(Map<String, dynamic> json) {
    return ApiStage(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      chain: ApiChain.fromJson(json['chain']),
    );
  }
}
