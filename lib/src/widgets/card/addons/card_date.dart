import 'package:flutter/material.dart';

import 'package:gigaturnip/src/theme/index.dart';
import 'package:intl/intl.dart';

class CardDate extends StatelessWidget {
  final DateTime? date;

  const CardDate({Key? key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    if (date == null) {
      return const SizedBox.shrink();
    }

    final textStyle = TextStyle(
      color: theme.neutral70,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    return Row(
      children: [
        Icon(Icons.calendar_month, color: theme.neutral70),
        const SizedBox(width: 8),
        Text(
          '${date!.day} ${DateFormat.MMMM().format(date!)}',
          style: textStyle,
        ),
        const SizedBox(width: 20),
        Icon(Icons.alarm, color: theme.neutral70),
        const SizedBox(width: 8),
        Text(
          DateFormat.Hm().format(date!),
          style: textStyle,
        ),
      ],
    );
  }
}
