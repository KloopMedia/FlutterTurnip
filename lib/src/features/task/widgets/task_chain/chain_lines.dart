import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class StraightLine extends StatelessWidget {
  final Color color;

  const StraightLine({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Expanded(///
      child: Row(
        children: List.generate(19, (index) => Expanded(
          child: Container(
            color: index % 2 == 0
                ? Colors.transparent
                : color,
            height: 5,
            // decoration: BoxDecoration(
            //   borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            //   color: index % 2 == 0
            //       ? Colors.transparent
            //       : const Color(0xFF96ADFF),
            // ),
          ),
        )),
      ),
    );
  }
}


/*Widget straightLine = Expanded(
  child: Row(
    children: List.generate(19, (index) => Expanded(
      child: Container(
        color: index % 2 == 0
            ? Colors.transparent
            : const Color(0xFF2754F3),
        height: 5,
        // decoration: BoxDecoration(
        //   borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        //   color: index % 2 == 0
        //       ? Colors.transparent
        //       : const Color(0xFF96ADFF),
        // ),
      ),
    )),
  ),
);*/

/*class StraightLine extends CustomPainter {
  final Color color;

  const StraightLine({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    _drawDashedLine(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawDashedLine(Canvas canvas, Size size, Paint paint) {
    const int dashWidth = 15;
    const int dashSpace = 10;

    double startX = 0;
    double y = 0;

    // Repeat drawing until we reach the right edge.
    // In our example, size.with = 300 (from the SizedBox)
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, y),
          Offset(startX + dashWidth, y),
          paint
      );
      startX += dashWidth + dashSpace;
    }
  }
}*/

class CurveLeftLine extends CustomPainter {
  final Color color;

  const CurveLeftLine({required this.color});

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = color //const Color(0xFF2754F3)
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
  final Color color;

  const CurveRightLine({required this.color});

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = color
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