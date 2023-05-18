import 'package:flutter/material.dart';
import 'package:material_color_utilities/hct/hct.dart';
import 'package:material_color_utilities/palettes/tonal_palette.dart';

import 'typography.dart';

final lightTheme = ThemeData(
  fontFamily: 'Inter',
  colorScheme: lightColorScheme,
  textTheme: textTheme,
);

final darkTheme = ThemeData(
  fontFamily: 'Inter',
  colorScheme: darkColorScheme,
  textTheme: textTheme,
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF5E81FB),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFDCE1FF),
  onPrimaryContainer: Color(0xFF001551),
  secondary: Color(0xFF4459A9),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDEE1F9),
  onSecondaryContainer: Color(0xFF161B2C),
  tertiary: Color(0xFF74BF3B),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFA0F879),
  onTertiaryContainer: Color(0xFF062100),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFAFDFD),
  onBackground: Color(0xFF2E3132),
  surface: Color(0xFFFAFDFD),
  onSurface: Color(0xFF191C1D),
  surfaceVariant: Color(0xFFE2E1EC),
  onSurfaceVariant: Color(0xFF45464F),
  outline: Color(0xFF767680),
  outlineVariant: Color(0xFFC6C5D0),
  onInverseSurface: Color(0xFFEFF1F1),
  inverseSurface: Color(0xFF2E3132),
  inversePrimary: Color(0xFFB7C4FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF2D54CD),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB7C4FF),
  onPrimary: Color(0xFF002780),
  primaryContainer: Color(0xFF153CA8),
  onPrimaryContainer: Color(0xFFDCE1FF),
  secondary: Color(0xFFC2C5DD),
  onSecondary: Color(0xFF2B3042),
  secondaryContainer: Color(0xFF424659),
  onSecondaryContainer: Color(0xFFDEE1F9),
  tertiary: Color(0xFF85DB60),
  onTertiary: Color(0xFF0F3900),
  tertiaryContainer: Color(0xFF195200),
  onTertiaryContainer: Color(0xFFA0F879),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF171819),
  onBackground: Color(0xFFE1E3E3),
  surface: Color(0xFF1E1F21),
  onSurface: Color(0xFFC4C7C7),
  surfaceVariant: Color(0xFF45464F),
  onSurfaceVariant: Color(0xFFC6C5D0),
  outline: Color(0xFF90909A),
  outlineVariant: Color(0xFF45464F),
  onInverseSurface: Color(0xFF191C1D),
  inverseSurface: Color(0xFFE1E3E3),
  inversePrimary: Color(0xFF2D54CD),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFB7C4FF),
  scrim: Color(0xFF000000),
);

extension ThemeVariant on ColorScheme {
  bool get isLight => brightness == Brightness.light;

  bool get isDark => brightness == Brightness.dark;
}

extension CustomColors on ColorScheme {
  TonalPalette _tonalPaletteFromColor(Color color) {
    final hctColor = Hct.fromInt(color.value);
    return TonalPalette.of(hctColor.hue, hctColor.chroma);
  }

  Color getPrimaryTonalColor(int tone) => Color(_tonalPaletteFromColor(primary).get(tone));

  Color get statusGreen =>
      isLight ? const Color.fromRGBO(75, 150, 39, 1) : const Color.fromRGBO(133, 219, 96, 1);

  Color get statusYellow =>
      isLight ? const Color.fromRGBO(206, 186, 9, 1) : const Color.fromRGBO(255, 237, 171, 1);

  Color get statusRed =>
      isLight ? const Color.fromRGBO(212, 103, 103, 1) : const Color.fromRGBO(255, 180, 171, 1);
}

extension Neutral on ColorScheme {
  Color get neutral0 => const Color(0xFF000000);

  Color get neutral10 => const Color(0xFF191C1D);

  Color get neutral20 => const Color(0xFF2E3132);

  Color get neutral30 => const Color(0xFF444748);

  Color get neutral40 => const Color(0xFF5C5F5F);

  Color get neutral50 => const Color(0xFF747878);

  Color get neutral60 => const Color(0xFF8E9192);

  Color get neutral70 => const Color(0xFFA9ACAC);

  Color get neutral80 => const Color(0xFFC4C7C7);

  Color get neutral90 => const Color(0xFFE1E3E3);

  Color get neutral95 => const Color(0xFFEFF1F1);

  Color get neutral99 => const Color(0xFFFAFDFD);

  Color get neutral100 => const Color(0xFFFFFFFF);
}

extension NeutralVariant on ColorScheme {
  Color get neutralVariant0 => const Color(0xFF000000);

  Color get neutralVariant10 => const Color(0xFF1A1B23);

  Color get neutralVariant20 => const Color(0xFF2F3038);

  Color get neutralVariant30 => const Color(0xFF45464F);

  Color get neutralVariant40 => const Color(0xFF5D5E67);

  Color get neutralVariant50 => const Color(0xFF767680);

  Color get neutralVariant60 => const Color(0xFF90909A);

  Color get neutralVariant70 => const Color(0xFFABAAB4);

  Color get neutralVariant80 => const Color(0xFFC6C5D0);

  Color get neutralVariant90 => const Color(0xFFE2E1EC);

  Color get neutralVariant95 => const Color(0xFFF1F0FA);

  Color get neutralVariant99 => const Color(0xFFFEFBFF);

  Color get neutralVariant100 => const Color(0xFFF1F3FF);
}
