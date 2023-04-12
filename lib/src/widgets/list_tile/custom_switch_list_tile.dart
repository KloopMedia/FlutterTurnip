import 'package:flutter/material.dart';

import 'custom_list_tile.dart';

class CustomSwitchListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final EdgeInsets? contentPadding;
  final EdgeInsets? leadingPadding;
  final void Function(bool)? onChanged;
  final bool value;

  const CustomSwitchListTile({
    Key? key,
    this.leading,
    this.title,
    this.contentPadding,
    this.leadingPadding,
    this.onChanged,
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
        child: Switch(
          value: value,
          onChanged: onChanged != null ? (newValue) => onChanged!(newValue) : null,
        ),
      ),
    );
  }
}
