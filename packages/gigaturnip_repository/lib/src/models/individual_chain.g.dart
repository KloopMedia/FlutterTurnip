// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualChain _$IndividualChainFromJson(Map<String, dynamic> json) =>
    IndividualChain(
      id: json['id'] as int,
      name: json['name'] as String,
      stagesData: (json['stagesData'] as List<dynamic>)
          .map((e) => TaskStageChainInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IndividualChainToJson(IndividualChain instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stagesData': instance.stagesData,
    };
