import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class CreatableTaskCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CreatableTaskCard({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.isLight ? Colors.white : Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
