import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

/// A dropdown that allows the user to select their country.
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
    final helperText = context.loc.localeName == 'en' ? '' : ' / Choose the country';
    final borderRadius = BorderRadius.circular(15);
    final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;

    final textStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: dropdownValueColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(context.loc.country, style: textStyle),
        ),
        DropdownButtonFormField<String>(
          style: textStyle,
          borderRadius: borderRadius,
          validator: (value) {
            if (value == null) {
              return context.loc.choose_country + helperText;
            }
            return null;
          },
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: theme.error,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.error),
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
            if (countryName != null) {
              final selected = countries.where((element) => element.name == countryName).toList();
              onTap(selected);
            }
          },
          items: countries.map((country) {
            return DropdownMenuItem<String>(
              value: country.name,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(country.name),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}