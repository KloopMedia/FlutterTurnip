import 'package:flutter/material.dart';
import 'package:gigaturnip/src/utilities/dialogs/generic_dialog.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

Future<void> showErrorDialog(
    BuildContext context,
    String text,
    ) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.error_occurred,
    content: text,
    optionsBuilder: () => {
      context.loc.ok: null,
    },
  );
}