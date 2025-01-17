import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class CampaignHeader extends StatelessWidget {
  final String title;

  const CampaignHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 21, 16, 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: theme.isLight ? theme.neutral30 : theme.neutral90,
        ),
      ),
    );
  }
}
