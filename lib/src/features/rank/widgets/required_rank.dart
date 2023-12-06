import 'package:flutter/material.dart';
import '../../../theme/index.dart';

class RequiredRank extends StatelessWidget {
  const RequiredRank({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          margin: const EdgeInsets.only(left: 5),
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: Shadows.elevation3,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: const Image(image: AssetImage('assets/images/rank_icon_sample.png'))),
        ),
        Container(
            width: 32,
            margin: const EdgeInsets.only(left: 5),
            padding: const EdgeInsets.only(left: 6, top: 7, right: 6, bottom: 6),
            decoration: BoxDecoration(
                color: theme.primary,
                shape: BoxShape.circle,
                boxShadow: Shadows.elevation3,
                border: Border.all(color: Colors.white)
            ),
            child: const Text(
              '+4',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
        ),
      ],
    );
  }
}