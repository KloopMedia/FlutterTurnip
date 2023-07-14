import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/widgets/dialogs/base_dialog.dart';
import 'package:go_router/go_router.dart';

class ReleaseTaskDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ReleaseTaskDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BaseDialog(
      title: context.loc.release_task_dialog_title,
      content: context.loc.release_task_dialog_body,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text(
            context.loc.yes,
            style: TextStyle(color: theme.error),
          ),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            context.loc.no,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
