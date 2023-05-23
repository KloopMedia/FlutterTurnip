import 'package:flutter/material.dart';


class CardDescription extends StatelessWidget {
  final String? text;

  const CardDescription(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return const SizedBox.shrink();
    }

    return Text(
      text!,
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 5,
    );
  }
}
