import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

class SignUpButton extends StatelessWidget {
  final FocusNode? focusNode;
  final void Function()? onPressed;

  const SignUpButton({Key? key, this.onPressed, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        focusNode: focusNode,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: theme.primary,
        ),
        onPressed: onPressed,
        child: Text(
          context.loc.further,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: theme.onPrimary,
          ),
        ),
      ),
    );
  }
}
