import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagBar extends StatelessWidget {
  const TagBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 13,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: const _TagChip('Test tag'),
          );
        },
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text;

  const _TagChip(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
