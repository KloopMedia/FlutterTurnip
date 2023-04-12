import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final EdgeInsets? contentPadding;
  final EdgeInsets? leadingPadding;
  final EdgeInsets? trailingPadding;
  final void Function()? onTap;

  const CustomListTile({
    Key? key,
    this.leading,
    this.title,
    this.trailing,
    this.onTap,
    this.contentPadding,
    this.leadingPadding,
    this.trailingPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.0,
        padding: contentPadding,
        child: Row(
          children: [
            if (leading != null)
              Padding(
                padding: leadingPadding ?? EdgeInsets.zero,
                child: leading!,
              ),
            Expanded(
              child: title != null ? title! : const SizedBox.shrink(),
            ),
            if (trailing != null)
              Padding(
                padding: trailingPadding ?? EdgeInsets.zero,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}
