// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Category',
      json,
      ($checkedConvert) {
        final val = Category(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          outCategories: $checkedConvert('out_categories',
              (v) => (v as List<dynamic>).map((e) => e as String?).toList()),
        );
        return val;
      },
      fieldKeyMap: const {'outCategories': 'out_categories'},
    );
