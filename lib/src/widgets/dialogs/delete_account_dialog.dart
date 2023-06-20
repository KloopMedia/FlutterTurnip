import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:go_router/go_router.dart';

import 'base_dialog.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BaseDialog(
      title: context.loc.delete_account_dialog_title,
      content: context.loc.delete_account_dialog_body,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(const DeleteAccount());
          },
          child: Text(
            context.loc.delete_account_confirmation,
            style: TextStyle(color: theme.error),
          ),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            context.loc.cancel,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
