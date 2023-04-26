import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

Widget straightLine = Expanded(
  child: Row(
    children: List.generate(19, (index) => Expanded(
      child: Container(
        // color: index % 2 == 0
        //     ? Colors.transparent
        //     : Colors.blueAccent,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          color: index % 2 == 0
              ? Colors.transparent
              : Colors.blueAccent,
        ),
      ),
    )),
  ),
);

// class StraightLineWithPadding extends StatelessWidget {
//   final bool rightPadding;
//
//   const StraightLineWithPadding({Key? key, required this.rightPadding}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         if (rightPadding) const SizedBox(width: 40.0),
//         straightLine,
//         if (!rightPadding) const SizedBox(width: 40.0),
//       ],
//     );
//   }
// }


class CurveLeftLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    var startPoint = Offset(size.width, size.height - 120);
    var controlPoint1 = Offset(0, size.height / 6);
    var controlPoint2 = Offset(0, 5 * size.height / 6);
    var endPoint = Offset(size.width, size.height);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        endPoint.dx, endPoint.dy);

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[15.0, 10.5]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CurveRightLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blueAccent //96ADFF, 2754F3  dark = DFE6FF, 7694FF
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    var startPoint = Offset(0, size.height - 120);
    var controlPoint1 = Offset(size.width, size.height / 6);
    var controlPoint2 = Offset(size.width, 5 * size.height / 6);
    var endPoint = Offset(0, size.height);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        endPoint.dx, endPoint.dy);

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[15.0, 10.5]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}