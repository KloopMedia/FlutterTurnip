import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class TaskReturnedDialog extends StatelessWidget {
  final VoidCallback? onPop;
  const TaskReturnedDialog({super.key, this.onPop});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(58),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        context.loc.task_failed,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.neutral40),
      ),
      actions: [
        SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              Navigator.pop(context);
              if (onPop != null) {
                onPop!();
              }
            },
            child: Text(context.loc.ok),
          ),
        )
      ],
    );
  }
}
