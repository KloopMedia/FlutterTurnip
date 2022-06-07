import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stage.g.dart';

@JsonSerializable()
class Stage extends Equatable {
  final int id;
  final String name;
  final String description;
  final Chain chain;

  const Stage({
    required this.id,
    required this.name,
    required this.description,
    required this.chain,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return _$StageFromJson(json);
  }

  @override
  List<Object?> get props => [id, name, description, chain];
}
