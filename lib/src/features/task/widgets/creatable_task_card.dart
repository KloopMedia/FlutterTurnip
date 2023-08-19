import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class CreatableTaskCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final BoxConstraints? constraints;

  const CreatableTaskCard({
    super.key,
    required this.title,
    required this.onPressed,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
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
          maxLines: 2,
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
