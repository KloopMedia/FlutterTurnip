// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'pagination_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationWrapper<T> _$PaginationWrapperFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    $checkedCreate(
      'PaginationWrapper',
      json,
      ($checkedConvert) {
        final val = PaginationWrapper<T>(
          count: $checkedConvert('count', (v) => (v as num).toInt()),
          next: $checkedConvert('next', (v) => v as String?),
          previous: $checkedConvert('previous', (v) => v as String?),
          results: $checkedConvert(
              'results', (v) => (v as List<dynamic>).map(fromJsonT).toList()),
        );
        return val;
      },
    );
