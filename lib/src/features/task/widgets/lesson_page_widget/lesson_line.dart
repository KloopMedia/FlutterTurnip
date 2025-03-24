import 'package:flutter/material.dart';

class LessonLine extends StatefulWidget {
  final bool isLast;
  final bool isComplete;

  const LessonLine({super.key, required this.isLast, required this.isComplete});

  @override
  State<LessonLine> createState() => _LessonLineState();
}

class _LessonLineState extends State<LessonLine> {
  final xCord = const Offset(24, 48);
  final yCord = const Offset(24, 54 + 32);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(
        color: widget.isComplete ? Color(0xFF5E81FB) : Color(0xFFD8D8D8),
        lines: [],
        currentPoints: [xCord, widget.isLast ? xCord : yCord],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Color color;
  final List<List<Offset>> lines;
  final List<Offset> currentPoints;

  const LinePainter({required this.lines, required this.currentPoints, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0;

    for (final line in lines) {
      canvas.drawLine(line[0], line[1], paint);
    }

    if (currentPoints.length == 2) {
      canvas.drawLine(currentPoints[0], currentPoints[1], paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}
