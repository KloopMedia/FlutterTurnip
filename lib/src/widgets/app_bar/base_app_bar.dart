import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget {
  final Widget? title;
  final List<Widget>? leading;
  final List<Widget>? actions;
  final List<Widget>? subActions;
  final Widget? middle;
  final Widget? bottom;
  final IconThemeData? iconTheme;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? titleSpacing;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const BaseAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.subActions,
    this.middle,
    this.bottom,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.iconTheme,
    this.titleSpacing,
    this.border,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor, border: border, boxShadow: boxShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding ?? EdgeInsets.zero,
            child: IconTheme(
              data: iconTheme ?? const IconThemeData.fallback(),
              child: Row(
                children: [
                  if (leading != null) ...leading!,
                  Expanded(
                    child: title != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: titleSpacing ?? 0),
                            child: title,
                          )
                        : const SizedBox.shrink(),
                  ),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
          ),
          Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (subActions != null) ...subActions!,
              ],
            ),
          ),
          if (middle != null) middle!,
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}
