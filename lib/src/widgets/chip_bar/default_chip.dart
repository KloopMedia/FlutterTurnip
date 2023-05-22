import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class DefaultChip extends StatefulWidget {
  final String label;
  final bool active;
  final void Function()? onPressed;

  const DefaultChip({
    Key? key,
    required this.label,
    this.active = false,
    this.onPressed,
  }) : super(key: key);

  @override
  State<DefaultChip> createState() => _DefaultChipState();
}

class _DefaultChipState extends State<DefaultChip> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final Color defaultBackgroundColor;
    final Color activeBackgroundColor;
    final Color defaultFontColor;
    final Color activeFontColor;
    final Border border;

    if (theme.isLight) {
      defaultBackgroundColor = theme.neutral95;
      activeBackgroundColor = theme.getPrimaryTonalColor(70);
      defaultFontColor = theme.neutral40;
      activeFontColor = Colors.white;
      border = Border.all(color: Colors.transparent);
    } else {
      defaultBackgroundColor = Colors.transparent;
      activeBackgroundColor = theme.getPrimaryTonalColor(90);
      defaultFontColor = theme.neutral60;
      activeFontColor = Colors.black;
      border = Border.all(color: const Color.fromRGBO(54, 58, 58, 1));
    }

    final borderRadius = BorderRadius.circular(20);
    final backgroundColor = widget.active ? activeBackgroundColor : defaultBackgroundColor;
    final fontColor = widget.active ? activeFontColor : defaultFontColor;
    const hoverBackgroundColor = Colors.transparent;
    final hoverBorder = Border.all(color: theme.primary);
    final hoverFontColor = theme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: widget.onPressed,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (details) => setState(() {
            isHover = true;
          }),
          onExit: (details) => setState(() {
            isHover = false;
          }),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isHover ? hoverBackgroundColor : backgroundColor,
              borderRadius: borderRadius,
              border: isHover ? hoverBorder : border,
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 16,
                color: isHover ? hoverFontColor : fontColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
