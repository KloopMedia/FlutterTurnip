import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api show Category;

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final int id;
  final String name;
  final List<String?> outCategories;

  const Category({
    required this.id,
    required this.name,
    required this.outCategories
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryToJson(this);
  }

  factory Category.fromApiModel(api.Category model) {
    return Category(
      id: model.id,
      name: model.name,
      outCategories: model.outCategories
    );
  }

  @override
  List<Object?> get props => [id, name];
}