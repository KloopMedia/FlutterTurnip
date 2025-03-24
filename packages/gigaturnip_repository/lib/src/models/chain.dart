import 'package:equatable/equatable.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Chain;
import 'package:json_annotation/json_annotation.dart';

part 'chain.g.dart';

@JsonSerializable(explicitToJson: true)
class Chain extends Equatable {
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

  factory Chain.fromApiModel(api.Chain model) {
    return Chain(
      id: model.id,
      name: model.name,
      description: model.description,
      campaign: model.campaign,
      newTaskViewMode: model.newTaskViewMode
    );
  }

  Map<String, dynamic> toJson() => _$ChainToJson(this);

  @override
  List<Object?> get props => [id, name, description, campaign];
}
