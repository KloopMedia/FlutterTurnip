import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class SignInButton extends StatelessWidget {
  final void Function()? onPressed;

  const SignInButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return RichText(
        text: TextSpan(
            children: [
              TextSpan(
                text: context.loc.have_an_account,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: theme.neutral30,
                ),
              ),
              TextSpan(
                  text: context.loc.sign_in,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.primary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () => onPressed
              ),
            ]
        )
    );
  }
}
