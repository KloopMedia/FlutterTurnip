import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _sharedPreferences;

  ThemeCubit({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        super(ThemeState(themeMode: _fetchSavedLocale(sharedPreferences)));

  static ThemeMode _fetchSavedLocale(SharedPreferences sharedPreferences) {
    final savedValue = sharedPreferences.getString(Constants.sharedPrefThemeKey);
    if (savedValue == 'light' || savedValue == null) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  void switchTheme(bool isDark) {
    if (isDark) {
      _sharedPreferences.setString(Constants.sharedPrefThemeKey, 'dark');
      emit(const ThemeState(themeMode: ThemeMode.dark));
    } else {
      _sharedPreferences.setString(Constants.sharedPrefThemeKey, 'light');
      emit(const ThemeState(themeMode: ThemeMode.light));
    }
  }
}
