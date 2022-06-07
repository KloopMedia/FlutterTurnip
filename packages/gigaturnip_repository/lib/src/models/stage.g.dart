// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stage _$StageFromJson(Map<String, dynamic> json) => Stage(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      chain: Chain.fromJson(json['chain'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StageToJson(Stage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'chain': instance.chain,
    };
