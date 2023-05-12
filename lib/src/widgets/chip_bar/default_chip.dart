import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';

class DefaultChip extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final Color defaultBackgroundColor;
    final Color activeBackgroundColor;
    final Color defaultFontColor;
    final Color activeFontColor;

    if (theme.isLight) {
      defaultBackgroundColor = theme.neutral95;
      activeBackgroundColor = theme.getPrimaryTonalColor(70);
      defaultFontColor = theme.neutral40;
      activeFontColor = Colors.white;
    } else {
      defaultBackgroundColor = const Color.fromRGBO(54, 58, 58, 1);
      activeBackgroundColor = theme.primary;
      defaultFontColor = theme.neutral60;
      activeFontColor = Colors.black;
    }

    final borderRadius = BorderRadius.circular(20);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.zero,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? activeBackgroundColor : defaultBackgroundColor,
            borderRadius: borderRadius,
            border: theme.isDark ? Border.all(color: defaultBackgroundColor) : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: active ? activeFontColor : defaultFontColor,
            ),
          ),
        ),
      ),
    );
  }
}
