import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class SupportedLocale {
  final String name;
  final String code;
  const SupportedLocale(this.name, this.code);
}

/// A dropdown that allows the user to select their preferred language.
class LanguagePicker extends StatelessWidget {
  final String? errorMessage;
  final bool isLocaleSelected;

  const LanguagePicker({
    super.key,
    this.errorMessage,
    required this.isLocaleSelected,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(24);
    final theme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: theme.neutral30,
    );

    final supportedLocales = const [
      SupportedLocale('Кыргыз тили', 'ky'),
      SupportedLocale('English', 'en'),
      SupportedLocale('Русский', 'ru'),
      SupportedLocale('Українська', 'uk'),
    ];

    final currentLocaleCode = context.read<LocalizationBloc>().state.locale.languageCode.split('_').first;
    final dropdownValue = isLocaleSelected ? currentLocaleCode : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 236,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
            boxShadow: Shadows.elevation3,
            border: (errorMessage != null) ? Border.all(color: theme.error) : null,
          ),
          child: DropdownButtonFormField<String>(
            padding: const EdgeInsets.only(left: 6, right: 16),
            style: textStyle,
            borderRadius: borderRadius,
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.language),
              prefixIconColor: theme.primary,
              hintText: context.loc.choose_language,
              hintStyle: textStyle,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            isDense: true,
            icon: Icon(Icons.keyboard_arrow_down, color: theme.neutral30),
            value: dropdownValue,
            onChanged: (locale) {
              if (locale != null) {
                context.read<LocalizationBloc>().add(ChangeLocale(Locale(locale)));
              }
            },
            items: supportedLocales.map((locale) {
              return DropdownMenuItem<String>(
                value: locale.code,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(locale.name),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          errorMessage ?? '',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: theme.error,
          ),
        ),
      ],
    );
  }
}