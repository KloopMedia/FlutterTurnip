import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Localization on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;

  String _labelFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return loc.english;
      case 'ru':
        return loc.russian;
      case 'ky':
        return loc.kyrgyz;
      case 'uk':
        return loc.ukrainian;
      default:
        return locale.languageCode;
    }
  }

  Iterable<MapEntry<String, Locale>> get supportedLocales {
    return AppLocalizations.supportedLocales.map((locale) {
      return MapEntry<String, Locale>(_labelFromLocale(locale), locale);
    });
  }
}
