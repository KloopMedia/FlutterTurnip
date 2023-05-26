// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'individual_chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualChain _$IndividualChainFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'IndividualChain',
      json,
      ($checkedConvert) {
        final val = IndividualChain(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          stagesData: $checkedConvert(
              'stages_data',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TaskStageChainInfo.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'stagesData': 'stages_data'},
    );
