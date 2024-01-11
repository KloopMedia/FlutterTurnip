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
        color: theme.neutral30
    );

    final supportedLocales = [
      const SupportedLocale('Кыргыз тили', 'ky'),
      const SupportedLocale('English', 'en'),
      const SupportedLocale('Русский', 'ru'),
      const SupportedLocale('Українська', 'uk'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 206,
        // height: 40,
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
            value: (isLocaleSelected == false) ? null : context.read<LocalizationBloc>().state.locale.languageCode.split('_').first,
            onChanged: (locale) {
              if (locale != null) {
                context.read<LocalizationBloc>().add(ChangeLocale(Locale(locale)));
              }
            },
            // selectedItemBuilder:  (BuildContext context) {
            //   return locales.map((SupportedLocale locale) {
            //     return Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Image.asset('assets/images/world.png', height: 20),
            //         const SizedBox(width: 8),
            //         Text(
            //           locale.name,
            //           style: textStyle,
            //         ),
            //       ],
            //     );
            //   }).toList();
            // },
            items: supportedLocales.map((SupportedLocale locale) => DropdownMenuItem<String>(
              value: locale.code,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(locale.name),
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          errorMessage ?? '',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: theme.error
          ),
        )
      ],
    );
  }
}

class CountryPicker extends StatelessWidget {
  final String? campaignCountry;
  final List countries;
  final Function(List country) onTap;

  const CountryPicker({
    super.key,
    required this.campaignCountry,
    required this.countries,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final helperText = (context.loc.localeName == 'en') ? '' : ' / Choose the country';
    final borderRadius = BorderRadius.circular(15);
    final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;
    final textStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
        color: dropdownValueColor
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            context.loc.country,
            style: textStyle,
          ),
        ),
        DropdownButtonFormField<String>(
          style: textStyle,
          borderRadius: borderRadius,
          validator: (value) {
            if (value == null) {
              return context.loc.choose_country + helperText;
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            errorStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: theme.error
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.isLight ? theme.error : theme.error),
              borderRadius: BorderRadius.circular(15.0),
            ),
            hintText: context.loc.choose_country,
            hintStyle: TextStyle(
              color: hintTextColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.isLight ? theme.neutral95 : theme.onSecondary),
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.primary),
              borderRadius: BorderRadius.circular(15.0),
            ),
            filled: true,
            fillColor: theme.isLight ? theme.neutral95 : theme.onSecondary,
          ),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: theme.primary),
          value: campaignCountry,
          onChanged: (countryName) {
            final country = countries.where((element) => element.name == countryName).toList();
            onTap(country);
          },
          items: countries.map((country) => DropdownMenuItem<String>(
            value: country.name,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(country.name),
            ),
          )).toList(),
        ),
      ],
    );
  }
}
