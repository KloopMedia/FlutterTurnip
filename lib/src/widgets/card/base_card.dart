import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class BaseCard extends StatefulWidget {
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
  State<BaseCard> createState() => _BaseCardState();
}

class _BaseCardState extends State<BaseCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(15);
    final shape = RoundedRectangleBorder(borderRadius: borderRadius);
    final backgroundColor = theme.isLight ? theme.onSecondary : theme.neutral12;

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (details) => setState(() {
          isHover = true;
        }),
        onExit: (details) => setState(() {
          isHover = false;
        }),
        child: Container(
          width: widget.size?.width,
          height: widget.size?.height,
          decoration: BoxDecoration(
            boxShadow: isHover ? Shadows.elevation4 : Shadows.elevation2,
            borderRadius: borderRadius,
            color: backgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: widget.flex,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: backgroundColor,
                  shape: shape,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: widget.body,
                  ),
                ),
              ),
              if (widget.bottom != null)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: widget.bottom,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
