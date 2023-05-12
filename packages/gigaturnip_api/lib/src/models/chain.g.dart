// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chain _$ChainFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Chain',
      json,
      ($checkedConvert) {
        final val = Chain(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
          campaign: $checkedConvert('campaign', (v) => v as int?),
          stagesData: $checkedConvert(
              'stages_data',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      TaskStageChainInfo.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'stagesData': 'stages_data'},
    );
