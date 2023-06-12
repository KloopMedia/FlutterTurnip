import 'dart:io';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {

  FilterBloc()
      : super(const FilterState({})) {
    on<SelectFilterItem>(_onSelectFilterItem);
  }

  void _onSelectFilterItem(SelectFilterItem event, Emitter<FilterState> emit) {
    final query = event.query;
    emit(FilterState(query));
  }
}
