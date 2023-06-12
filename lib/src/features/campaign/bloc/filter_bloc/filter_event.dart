part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class SelectFilterItem extends FilterEvent {
  final Map<String, dynamic> query;

  const SelectFilterItem(this.query);

  @override
  List<Object?> get props => [query];
}