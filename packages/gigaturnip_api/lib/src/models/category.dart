import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int? id;
  final String name;
  final List<int?> outCategories;

  const Category({
    required this.id,
    required this.name,
    required this.outCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }
}