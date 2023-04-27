import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class BaseCard extends StatelessWidget {
  final Widget body;
  final Widget? bottom;
  final Color? color;
  final Size? size;
  final int flex;
  final void Function()? onTap;

  const BaseCard({
    Key? key,
    required this.body,
    this.bottom,
    this.onTap,
    this.color,
    this.size,
    this.flex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(15);
    final shape = RoundedRectangleBorder(borderRadius: borderRadius);
    final backgroundColor = theme.isLight ? theme.onSecondary : theme.onSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size?.width,
        height: size?.height,
        decoration: BoxDecoration(
          boxShadow: Shadows.elevation3,
          borderRadius: borderRadius,
          color: backgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: flex,
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                color: theme.onSecondary,
                shape: shape,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: body,
                ),
              ),
            ),
            if (bottom != null)
              Padding(
                padding: const EdgeInsets.all(10),
                child: bottom,
              ),
          ],
        ),
      ),
    );
  }
}
