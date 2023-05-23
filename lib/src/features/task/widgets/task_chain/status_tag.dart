import 'package:flutter/material.dart';

class StatusTag extends StatelessWidget {
  final bool complete;

  const StatusTag({
    Key? key,
    required this.complete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: complete ? const Color(0xFF4B9627) : const Color(0xFFDFC902),
      // padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      visualDensity: VisualDensity.compact,
      label: Text(
        complete ? 'Выполнено' : 'Текущее',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
