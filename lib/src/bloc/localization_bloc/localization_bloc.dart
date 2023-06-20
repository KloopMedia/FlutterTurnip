import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final SharedPreferences _sharedPreferences;

  LocalizationBloc({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        super(LocalizationState(_fetchSavedLocale(sharedPreferences))) {
    on<ChangeLocale>(_onChangeLocale);
  }

  static Locale _fetchSavedLocale(SharedPreferences sharedPreferences) {
    String defaultCode;
    try {
      const supportedLocales = AppLocalizations.supportedLocales;
      final systemLocale = PlatformDispatcher.instance.locale.languageCode;
      if (supportedLocales.contains(Locale(systemLocale))) {
        defaultCode = systemLocale;
      } else {
        defaultCode = 'en';
      }
    } on UnsupportedError {
      defaultCode = 'en';
    }
    return Locale(sharedPreferences.getString(Constants.sharedPrefLocaleKey) ?? defaultCode);
  }

  void _onChangeLocale(ChangeLocale event, Emitter<LocalizationState> emit) {
    final locale = event.locale;
    _sharedPreferences.setString(Constants.sharedPrefLocaleKey, locale.languageCode);
    emit(LocalizationState(locale));
  }
}
