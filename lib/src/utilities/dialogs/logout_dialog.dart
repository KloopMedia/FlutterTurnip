import 'package:flutter/material.dart';
import 'package:gigaturnip/src/utilities/dialogs/generic_dialog.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';


Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: context.loc.logout,
    content: context.loc.are_you_sure_logout,
    optionsBuilder: () => {
      context.loc.cancel: false,
      context.loc.logout: true,
    },
  ).then(
    (value) => value ?? false,
  );
}
