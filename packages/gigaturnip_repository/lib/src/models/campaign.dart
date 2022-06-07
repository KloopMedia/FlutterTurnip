import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign extends Equatable {
  final int id;
  final String name;
  final String description;

  const Campaign({required this.id, required this.name, required this.description});

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return _$CampaignFromJson(json);
  }

  @override
  List<Object?> get props => [id, name, description];
}
