import 'package:flutter/material.dart';

class DialogButtonOutlined extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const DialogButtonOutlined({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            side: BorderSide(color: theme.primary, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
