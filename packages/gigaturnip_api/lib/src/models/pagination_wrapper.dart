import 'package:json_annotation/json_annotation.dart';

part 'pagination_wrapper.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationWrapper<T> {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  PaginationWrapper({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PaginationWrapper.fromJson(json, T Function(Object? json) fromJsonT) {
    return _$PaginationWrapperFromJson(json, fromJsonT);
  }

  PaginationWrapper<K> copyWith<K>({
    int? count,
    String? next,
    String? previous,
    required List<K> results,
  }) =>
      PaginationWrapper<K>(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results,
      );

  bool get hasNext => next != null ? true : false;

  bool get hasPrevious => previous != null ? true : false;
}