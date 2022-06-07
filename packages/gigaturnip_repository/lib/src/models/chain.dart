import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chain.g.dart';

@JsonSerializable()
class Chain extends Equatable {
  final int id;
  final String name;
  final String description;
  final int campaign;

  const Chain({
    required this.id,
    required this.name,
    required this.description,
    required this.campaign,
  });

  factory Chain.fromJson(Map<String, dynamic> json) {
    return _$ChainFromJson(json);
  }

  @override
  List<Object?> get props => [id, name, description, campaign];
}
