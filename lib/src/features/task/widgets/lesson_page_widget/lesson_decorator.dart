import 'package:flutter/material.dart';

class LessonDecorator extends StatelessWidget {
  final bool isComplete;

  const LessonDecorator({super.key, required this.isComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
      ),
      child: switch (isComplete) {
        true => Image.asset('assets/icon/complete_task.png'),
        false => Image.asset('assets/icon/open_task.png')
      },
    );
  }
}
