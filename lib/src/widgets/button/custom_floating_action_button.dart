import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final EdgeInsets? padding;
  final void Function() onPressed;

  const CustomFloatingActionButton({super.key, required this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 10, right: 8),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: theme.primary,
        onPressed: onPressed,
        child: Icon(Icons.add, color: theme.isLight ? Colors.white : Colors.black,),
      ),
    );
  }
}
