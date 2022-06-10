// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'case.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Case _$CaseFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Case',
      json,
      ($checkedConvert) {
        final val = Case(
          id: $checkedConvert('id', (v) => v as int),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updated_at', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created_at', 'updatedAt': 'updated_at'},
    );
