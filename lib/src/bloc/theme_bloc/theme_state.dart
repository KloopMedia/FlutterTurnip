part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.light});

  bool get isLight => themeMode == ThemeMode.light;

  bool get isDark => themeMode == ThemeMode.dark;

  @override
  List<Object> get props => [themeMode];
}
