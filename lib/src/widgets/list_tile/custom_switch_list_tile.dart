import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_list_tile.dart';

class CustomSwitchListTile extends StatelessWidget {
  final bool cupertinoVariant;
  final Widget? leading;
  final Widget? title;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? leadingPadding;
  final void Function(bool)? onChanged;
  final bool value;

  const CustomSwitchListTile({
    Key? key,
    this.leading,
    this.title,
    this.contentPadding,
    this.leadingPadding,
    this.onChanged,
    this.cupertinoVariant = false,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: leading,
      title: title,
      contentPadding: contentPadding,
      leadingPadding: leadingPadding,
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      trailing: SizedBox(
        width: 38,
        child: Builder(builder: (context) {
          if (cupertinoVariant) {
            return CupertinoSwitch(
              value: value,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: onChanged != null ? (newValue) => onChanged!(newValue) : null,
            );
          }
          return Switch(
            value: value,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: onChanged != null ? (newValue) => onChanged!(newValue) : null,
          );
        }),
      ),
    );
  }
}
