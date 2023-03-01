import 'package:json_annotation/json_annotation.dart';

part 'dynamic_schema.g.dart';

@JsonSerializable()
class DynamicSchema {
  final int status;
  final Map<String, dynamic> schema;

  DynamicSchema({required this.status, required this.schema});

  factory DynamicSchema.fromJson(json) {
    return _$DynamicSchemaFromJson(json);
  }
}
