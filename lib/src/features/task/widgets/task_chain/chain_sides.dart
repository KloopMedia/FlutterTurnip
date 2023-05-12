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

    if (even) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: 40.0),
          StraightLine(color: color),
          // CustomPaint(
          //   size: const Size(200, 120),
          //   painter: StraightLine(color: color),
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: CustomPaint(
              size: const Size(40, 120),
              painter: CurveRightLine(color: color),
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
            padding: const EdgeInsets.only(bottom: 5.0),
            child: CustomPaint(
              size: const Size(40, 120),
              painter: CurveLeftLine(color: color),
            ),
          ),
          StraightLine(color: color),
          // CustomPaint(
          //   size: const Size(200, 120),
          //   painter: StraightLine(color: color),
          // ),
          const SizedBox(width: 40.0),
        ],
      );
    }
  }
}


// Widget rightSide = Row(
//   mainAxisAlignment: MainAxisAlignment.end,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     const SizedBox(width: 40.0),
//     straightLine,
//     Padding(
//       padding: const EdgeInsets.only(top: 5.0),
//       child: CustomPaint(
//         size: const Size(40, 120),
//         painter: CurveRightLine(),
//       ),
//     ),
//   ],
// );
//
// Widget leftSide =  Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Padding(
//       padding: const EdgeInsets.only(top: 5.0),
//       child: CustomPaint(
//         size: const Size(40, 120),
//         painter: CurveLeftLine(),
//       ),
//     ),
//     straightLine,
//     const SizedBox(width: 40.0),
//   ],
// );