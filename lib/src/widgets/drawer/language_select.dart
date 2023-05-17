import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

class LanguageSelect extends StatelessWidget {
  final Widget? icon;
  final Color? iconColor;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;

  const LanguageSelect({
    Key? key,
    this.icon,
    this.style,
    this.iconColor,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      padding: contentPadding,
      style: style,
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(minWidth: 20, maxHeight: 48),
        prefixIcon: icon,
        prefixIconColor: iconColor,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      isExpanded: true,
      isDense: true,
      icon: Icon(Icons.keyboard_arrow_down, color: iconColor),
      value: context.read<LocalizationBloc>().state.locale.languageCode.split('_').first,
      onChanged: (locale) {
        if (locale != null) {
          context.read<LocalizationBloc>().add(ChangeLocale(Locale(locale)));
        }
      },
      items: const [
        DropdownMenuItem(
          value: 'en',
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: 'ky',
          child: Text('Кыргыз тили'),
        ),
        DropdownMenuItem(
          value: 'ru',
          child: Text('Русский'),
        ),
      ],
    );
  }
}
