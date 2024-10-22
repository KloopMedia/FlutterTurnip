// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chain _$ChainFromJson(Map<String, dynamic> json) => Chain(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      campaign: (json['campaign'] as num).toInt(),
    );

Map<String, dynamic> _$ChainToJson(Chain instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'campaign': instance.campaign,
    };
