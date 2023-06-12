part of 'filter_bloc.dart';

// abstract class FilterState extends Equatable {
//   const FilterState();
// }
//
// class FilterInitial extends FilterState {
//   @override
//   List<Object?> get props => [];
// }
//
// class FilterSelected extends FilterState {
//   final List<Map<String, dynamic>> query;
//
//   const FilterSelected(this.query);
//
//   @override
//   List<Object?> get props => [query];
// }

class FilterState extends Equatable {
  final Map<String, dynamic> query;

  const FilterState(this.query);

  @override
  List<Object?> get props => [query];
}

