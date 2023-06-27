import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Country;

part 'country.g.dart';

@JsonSerializable()
class Country extends Equatable {
  final int id;
  final String name;

  const Country({
    required this.id,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return _$CountryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CountryToJson(this);
  }

  factory Country.fromApiModel(api.Country model) {
    return Country(
        id: model.id,
        name: model.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}