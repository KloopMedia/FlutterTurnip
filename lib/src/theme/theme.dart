import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final lightTheme = ThemeData(
  fontFamily: 'Inter',
  colorScheme: lightColorScheme,
  textTheme: Typography.englishLike2021
      .apply(fontSizeFactor: 1.sp)
      .apply(bodyColor: lightColorScheme.onSurfaceVariant)
      .apply(displayColor: lightColorScheme.onSurfaceVariant),
);

final darkTheme = ThemeData(
  fontFamily: 'Inter',
  colorScheme: darkColorScheme,
  textTheme: Typography.englishLike2021.apply(fontSizeFactor: 1.sp),
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF5E81FB),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFDCE1FF),
  onPrimaryContainer: Color(0xFF001551),
  secondary: Color(0xFF4459A9),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDDE1FF),
  onSecondaryContainer: Color(0xFF001552),
  tertiary: Color(0xFF4B9627),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFA0F879),
  onTertiaryContainer: Color(0xFF062100),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFAFDFD),
  onBackground: Color(0xFF191C1D),
  outline: Color(0xFF767680),
  onInverseSurface: Color(0xFFEFF1F1),
  inverseSurface: Color(0xFF2E3132),
  inversePrimary: Color(0xFFB7C4FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF2D54CD),
  outlineVariant: Color(0xFFC6C5D0),
  scrim: Color(0xFF000000),
  surface: Color(0xFFF8FAFA),
  onSurface: Color(0xFF191C1D),
  surfaceVariant: Color(0xFFE2E1EC),
  onSurfaceVariant: Color(0xFF45464F),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB7C4FF),
  onPrimary: Color(0xFF002681),
  primaryContainer: Color(0xFF0039B4),
  onPrimaryContainer: Color(0xFFDCE1FF),
  secondary: Color(0xFFB7C4FF),
  onSecondary: Color(0xFF0D2878),
  secondaryContainer: Color(0xFF2A4190),
  onSecondaryContainer: Color(0xFFDDE1FF),
  tertiary: Color(0xFF85DB60),
  onTertiary: Color(0xFF0F3900),
  tertiaryContainer: Color(0xFF195200),
  onTertiaryContainer: Color(0xFFA0F879),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C1D),
  onBackground: Color(0xFFE1E3E3),
  outline: Color(0xFF90909A),
  onInverseSurface: Color(0xFF191C1D),
  inverseSurface: Color(0xFFE1E3E3),
  inversePrimary: Color(0xFF2D54CD),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFB7C4FF),
  outlineVariant: Color(0xFF45464F),
  scrim: Color(0xFF000000),
  surface: Color(0xFF101415),
  onSurface: Color(0xFFC4C7C7),
  surfaceVariant: Color(0xFF45464F),
  onSurfaceVariant: Color(0xFFC6C5D0),
);
