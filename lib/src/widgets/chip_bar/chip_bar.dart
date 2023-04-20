import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipBar extends StatelessWidget {
  const ChipBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 13,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: _Chip('Test tag'),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;

  const _Chip(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      visualDensity: VisualDensity.compact,
      label: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: const Color(0xFF5C5F5F),
        ),
      ),
    );
  }
}
