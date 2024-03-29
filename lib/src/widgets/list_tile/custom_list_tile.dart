import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? leadingPadding;
  final EdgeInsetsGeometry? trailingPadding;
  final void Function()? onTap;
  final double height;

  const CustomListTile({
    Key? key,
    this.leading,
    this.title,
    this.trailing,
    this.onTap,
    this.contentPadding,
    this.leadingPadding,
    this.trailingPadding,
    this.height = 48.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
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
