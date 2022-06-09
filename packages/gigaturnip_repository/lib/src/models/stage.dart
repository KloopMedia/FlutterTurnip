import 'package:equatable/equatable.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Stage;

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

  factory Stage.fromApiModel(api.Stage model) {
    return Stage(
      id: model.id,
      name: model.name,
      description: model.description,
      chain: Chain.fromApiModel(model.chain),
    );
  }

  @override
  List<Object?> get props => [id, name, description, chain];
}
