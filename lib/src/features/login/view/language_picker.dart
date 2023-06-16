import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    final theme = Theme.of(context).colorScheme;

    final kg = Image.asset('assets/images/kg.png', height: 20);
    final en = Image.asset('assets/images/en.png', height: 20);
    final ru = Image.asset('assets/images/ru.png', height: 20);

    return Container(
      width: 125,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: Shadows.elevation3,
      ),
      child: DropdownButtonFormField<String>(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: theme.neutral30),
        borderRadius: borderRadius,
        dropdownColor: Colors.white,
        decoration: const InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        isDense: true,
        icon: Icon(Icons.keyboard_arrow_down, color: theme.neutral30),
        value: context.read<LocalizationBloc>().state.locale.languageCode.split('_').first,
        onChanged: (locale) {
          if (locale != null) {
            context.read<LocalizationBloc>().add(ChangeLocale(Locale(locale)));
          }
        },
        items: [
          DropdownMenuItem(
            value: 'en',
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  constraints: const BoxConstraints(maxWidth: 30),
                  height: 20,
                  child: en,
                ),
                const Text('EN'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'ky',
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  constraints: const BoxConstraints(maxWidth: 30),
                  height: 20,
                  child: kg,
                ),
                const Text('KG'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'ru',
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  constraints: const BoxConstraints(maxWidth: 30),
                  height: 20,
                  child: ru,
                ),
                const Text('RU'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
