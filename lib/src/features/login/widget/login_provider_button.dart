import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class LoginProviderButton extends StatelessWidget {
  final Color? color;
  final BorderSide? border;
  final void Function()? onPressed;
  final Widget icon;
  final Widget child;

  const LoginProviderButton({
    Key? key,
    this.color,
    this.onPressed,
    required this.icon,
    required this.child,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: context.isSmall || context.isMedium ? 0 : 1,
      child: SizedBox(
        height: 54.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            side: border,
            backgroundColor: color,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              icon,
              const SizedBox(width: 15.0),
              Padding(
                padding:const EdgeInsets.only(top: 4.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
