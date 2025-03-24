import 'package:json_annotation/json_annotation.dart';

part 'chain.g.dart';

@JsonSerializable()
class Chain {
  final int id;
  final String name;
  final String description;
  final int campaign;
  final bool newTaskViewMode;

  const Chain({
    required this.id,
    required this.name,
    required this.description,
    required this.campaign,
    this.newTaskViewMode = false
  });

  factory Chain.fromJson(Map<String, dynamic> json) {
    return _$ChainFromJson(json);
  }
}
