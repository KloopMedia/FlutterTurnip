import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class BaseDialog extends StatelessWidget {
  final String? title;
  final String content;
  final List<Widget> actions;
  final MainAxisAlignment? actionsAlignment;

  const BaseDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
    this.actionsAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(58),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: title != null ? Text(
        title!,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: theme.onSurface),
      ) : SizedBox.shrink(),
      content: SizedBox(
        width: (kIsWeb) ? 450 : double.infinity,
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: theme.neutral40, fontWeight: title == null ? FontWeight.w600 : null),
        ),
      ),
      actions: actions,
      actionsAlignment: actionsAlignment,
    );
  }
}
