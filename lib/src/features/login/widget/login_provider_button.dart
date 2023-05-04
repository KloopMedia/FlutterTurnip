import 'package:flutter/material.dart';

class LoginProviderButton extends StatelessWidget {
  final Color? color;
  final void Function()? onPressed;
  final Widget icon;
  final Widget child;

  const LoginProviderButton({Key? key, this.color, this.onPressed, required this.icon, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: BorderSide(
            color: Colors.black.withOpacity(0.5),
          ),
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 15.0),
            child,
          ],
        ),
      ),
    );
  }
}
