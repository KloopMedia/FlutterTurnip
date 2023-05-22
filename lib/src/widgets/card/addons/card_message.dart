import 'package:flutter/material.dart';


class CardMessage extends StatelessWidget {
  final String? text;

  const CardMessage(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Icon(Icons.mail, color: Theme.of(context).colorScheme.tertiary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text!,
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
