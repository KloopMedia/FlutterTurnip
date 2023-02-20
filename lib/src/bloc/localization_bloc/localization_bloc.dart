import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc(Locale initLocale) : super(LocalizationState(initLocale)) {
    on<ChangeLocale>(_onChangeLocale);
  }

  void _onChangeLocale(ChangeLocale event, Emitter<LocalizationState> emit) {
    final locale = event.locale;
    emit(LocalizationState(locale));
  }
}
