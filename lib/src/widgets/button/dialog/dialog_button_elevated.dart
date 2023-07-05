import 'package:flutter/material.dart';

class DialogButtonElevated extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const DialogButtonElevated({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            )),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
