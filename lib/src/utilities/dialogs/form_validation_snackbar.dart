import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showWarningSnackBar ({
  required BuildContext context,
  required String content,
}) {
  final snackBar = SnackBar(
    duration: const Duration(minutes: 3),
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.all(20.0),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    content: Text(content, style: Theme.of(context).textTheme.headlineMedium),
    backgroundColor: (Colors.redAccent),
    action: SnackBarAction(
      label: context.loc.ok,
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
