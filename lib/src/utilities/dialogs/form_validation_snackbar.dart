import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showValidationFailedSnackBar ({
  required BuildContext context
}) {
  final snackBar = SnackBar(
    duration: const Duration(minutes: 3),
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.all(30.0),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    content: Text(context.loc.empty_form_fields, style: Theme.of(context).textTheme.headlineMedium),
    backgroundColor: (Colors.redAccent),
    action: SnackBarAction(
      label: 'OK',
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
