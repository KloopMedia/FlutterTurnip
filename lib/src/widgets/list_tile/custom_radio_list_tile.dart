import 'package:flutter/material.dart';

import '../widgets.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? leadingPadding;
  final void Function(T?) onChanged;
  final T value;
  final T? groupValue;

  const CustomRadioListTile({
    Key? key,
    this.leading,
    this.title,
    this.contentPadding,
    this.leadingPadding,
    required this.onChanged,
    required this.value,
    required this.groupValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: leading,
      title: title,
      contentPadding: contentPadding,
      leadingPadding: leadingPadding,
      onTap: () => onChanged(value),
      trailing: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: (val) => onChanged(value),
      ),
    );
  }
}
