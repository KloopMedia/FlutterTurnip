import 'package:flutter/material.dart';

class LessonDecorator extends StatelessWidget {
  final bool isComplete;
  final bool isActive;

  const LessonDecorator({super.key, required this.isComplete, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
      ),
      child: Builder(builder: (context) {
        if (isComplete) {
          return Image.asset('assets/icon/complete_task.png');
        } else if (isActive) {
          return Image.asset('assets/icon/current_task.png');
        } else {
          return Image.asset('assets/icon/open_task.png');
        }
      }),
    );
  }
}
