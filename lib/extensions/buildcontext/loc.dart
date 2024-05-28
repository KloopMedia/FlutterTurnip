import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Localization on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;

  String orderLabel(int index) {
    if (index > 9) {
      return "";
    }

    final labels_ru = [
      "Первый",
      "Второй",
      "Третий",
      "Четвертый",
      "Пятый",
      "Шестой",
      "Седьмой",
      "Восьмой",
      "Девятый"
    ];

    final labels_ky = [
      "Биринчи",
      "Экинчи",
      "Үчүнчү",
      "Төртүнчү",
      "Бешинчи",
      "Алтынчы",
      "Жетинчи",
      "Сегизинчи",
      "Тогузунчу"
    ];

    final labels_en = [
      "First",
      "Second",
      "Third",
      "Fourth",
      "Fifth",
      "Sixth",
      "Seventh",
      "Eighth",
      "Ninth"
    ];

    final labels_uk = [
      "Перший",
      "Другий",
      "Третій",
      "Четвертий",
      "П'ятий",
      "Шостий",
      "Сьомий",
      "Восьмий",
      "Дев'ятий"
    ];

    switch (Localizations.localeOf(this).languageCode) {
      case 'en':
        return labels_en[index];
      case 'ru':
        return labels_ru[index];
      case 'ky':
        return labels_ky[index];
      case 'uk':
        return labels_uk[index];
      default:
        return labels_en[index];
    }
  }

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
