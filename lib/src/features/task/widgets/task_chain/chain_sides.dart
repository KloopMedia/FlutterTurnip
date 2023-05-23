import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'chain_lines.dart';

class ChainSide extends StatelessWidget {
  final Color color;
  final bool even;

  const ChainSide({
    Key? key,
    required this.color,
    required this.even,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashWidth = context.isSmall ? 10.0 : 16.0;
    final dashSpace = context.isSmall ? 10.0 : 12.0;
    final strokeWidth = context.isSmall ? 6.0 : 7.0;

    if (even) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: 60.0),
          Expanded(
            child: CustomPaint(
              size: const Size(0.0, 0.0),
              painter: StraightLine(
                color: color,
                dashWidth: dashWidth,
                dashSpace: dashSpace,
                strokeWidth: strokeWidth
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CustomPaint(
              size: const Size(50, 120),
              painter: CurveRightLine(
                  color: color,
                  dashWidth: dashWidth,
                  dashSpace: dashSpace,
                  strokeWidth: strokeWidth
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomPaint(
              size: const Size(50, 120),
              painter: CurveLeftLine(
                  color: color,
                  dashWidth: dashWidth,
                  dashSpace: dashSpace,
                  strokeWidth: strokeWidth
              ),
            ),
          ),
          Expanded(
            child: CustomPaint(
              size: const Size(0.0, 0.0),
              painter: StraightLine(
                  color: color,
                  dashWidth: dashWidth,
                  dashSpace: dashSpace,
                  strokeWidth: strokeWidth
              ),
            ),
          ),
          const SizedBox(width: 60.0),
        ],
      );
    }
  }
}