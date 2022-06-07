// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chain _$ChainFromJson(Map<String, dynamic> json) => Chain(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      campaign: json['campaign'] as int,
    );

Map<String, dynamic> _$ChainToJson(Chain instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'campaign': instance.campaign,
    };
