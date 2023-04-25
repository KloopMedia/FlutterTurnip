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
  primary: Color(0xFF2D54CD),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFDCE1FF),
  onPrimaryContainer: Color(0xFF001551),
  secondary: Color(0xFF4459A9),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDDE1FF),
  onSecondaryContainer: Color(0xFF001552),
  tertiary: Color(0xFF236D00),
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
  onSecondary: Color(0xFF232427),
  secondaryContainer: Color(0xff37373C),
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

extension ThemeVariant on ColorScheme {
  get isLight => brightness == Brightness.light;

  get isDark => brightness == Brightness.dark;
}

extension CustomColors on ColorScheme {
  get statusGreen =>
      isLight ? const Color.fromRGBO(75, 150, 39, 1) : const Color.fromRGBO(133, 219, 96, 1);

  get statusYellow =>
      isLight ? const Color.fromRGBO(206, 186, 9, 1) : const Color.fromRGBO(255, 237, 171, 1);

  get statusRed =>
      isLight ? const Color.fromRGBO(212, 103, 103, 1) : const Color.fromRGBO(255, 180, 171, 1);
}

extension Neutral on ColorScheme {
  get neutral0 => const Color(0xFF000000);

  get neutral10 => const Color(0xFF191C1D);

  get neutral20 => const Color(0xFF2E3132);

  get neutral30 => const Color(0xFF444748);

  get neutral40 => const Color(0xFF5C5F5F);

  get neutral50 => const Color(0xFF747878);

  get neutral60 => const Color(0xFF8E9192);

  get neutral70 => const Color(0xFFA9ACAC);

  get neutral80 => const Color(0xFFC4C7C7);

  get neutral90 => const Color(0xFFE1E3E3);

  get neutral95 => const Color(0xFFEFF1F1);

  get neutral99 => const Color(0xFFFAFDFD);

  get neutral100 => const Color(0xFFFFFFFF);
}

extension NeutralVariant on ColorScheme {
  get neutralVariant0 => const Color(0xFF000000);

  get neutralVariant10 => const Color(0xFF1A1B23);

  get neutralVariant20 => const Color(0xFF2F3038);

  get neutralVariant30 => const Color(0xFF45464F);

  get neutralVariant40 => const Color(0xFF5D5E67);

  get neutralVariant50 => const Color(0xFF767680);

  get neutralVariant60 => const Color(0xFF90909A);

  get neutralVariant70 => const Color(0xFFABAAB4);

  get neutralVariant80 => const Color(0xFFC6C5D0);

  get neutralVariant90 => const Color(0xFFE2E1EC);

  get neutralVariant95 => const Color(0xFFF1F0FA);

  get neutralVariant99 => const Color(0xFFFEFBFF);

  get neutralVariant100 => const Color(0xFFF1F3FF);
}
