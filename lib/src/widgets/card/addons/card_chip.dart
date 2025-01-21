import 'package:flutter/material.dart';

import 'package:gigaturnip/src/theme/index.dart';

class CardChip extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final Color? backgroundColor;
  final double? verticalPadding;
  final double? leftPadding;
  final double? rightPadding;
  final TextStyle? textStyle;

  const CardChip(
    this.text, {
    super.key,
    this.backgroundColor,
    this.fontColor,
    this.verticalPadding,
    this.leftPadding,
    this.rightPadding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final _fontColor = theme.isLight ? theme.neutral40 : theme.neutral80;
    final _backgroundColor = theme.isLight ? theme.neutralVariant95 : theme.neutralVariant20;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor ?? _backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            leftPadding ?? 10, verticalPadding ?? 3, rightPadding ?? 10, verticalPadding ?? 3),
        child: Text(text, style: textStyle ?? TextStyle(fontSize: 14, color: fontColor ?? _fontColor)),
      ),
    );
  }
}
