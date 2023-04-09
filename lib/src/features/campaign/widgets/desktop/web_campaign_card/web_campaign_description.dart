import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebCardDescription extends StatelessWidget {
  final String? text;

  const WebCardDescription(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return const SizedBox.shrink();
    }

    return Text(
      text!,
      style: TextStyle(
        fontSize: 16.sp,
        color: const Color(0xFF45464F),
      ),
    );
  }
}
