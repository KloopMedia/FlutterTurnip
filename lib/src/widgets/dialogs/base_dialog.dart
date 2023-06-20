import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;
  final MainAxisAlignment? actionsAlignment;

  const BaseDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
    this.actionsAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(58),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: theme.onSurface),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: theme.neutral40),
      ),
      actions: actions,
      actionsAlignment: actionsAlignment,
    );
  }
}
