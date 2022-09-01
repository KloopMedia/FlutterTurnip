import 'package:flutter/material.dart';
import 'package:gigaturnip/src/utilities/dialogs/generic_dialog.dart';

Future<bool> joinCampaignDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: '',
    content: 'Join campaign?',
    optionsBuilder: () => {
      'no': false,
      'yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
