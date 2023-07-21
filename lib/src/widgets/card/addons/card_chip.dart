import 'package:flutter/material.dart';

import 'package:gigaturnip/src/theme/index.dart';

class CardChip extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final Color? backgroundColor;

  const CardChip(this.text, {Key? key, this.backgroundColor, this.fontColor}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Text(text, style: TextStyle(fontSize: 14, color: fontColor ?? _fontColor)),
      ),
    );
  }
}
