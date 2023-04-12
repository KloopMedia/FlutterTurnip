import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

import '../list_tile/index.dart';

class ThemeSwitch extends StatelessWidget {
  final Text? title;
  final Icon? icon;
  final EdgeInsets? iconPadding;
  final EdgeInsetsGeometry? contentPadding;

  const ThemeSwitch({
    Key? key,
    this.title,
    this.iconPadding,
    this.icon,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: contentPadding ?? EdgeInsets.zero,
          child: CustomSwitchListTile(
            cupertinoVariant: true,
            leadingPadding: iconPadding,
            leading: icon,
            title: title,
            value: state.isDark,
            onChanged: (value) {
              context.read<ThemeCubit>().switchTheme(value);
            },
          ),
        );
      },
    );
  }
}
