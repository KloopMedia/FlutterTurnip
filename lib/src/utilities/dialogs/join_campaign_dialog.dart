import 'package:flutter/material.dart';
import 'package:gigaturnip/src/utilities/dialogs/generic_dialog.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

Future<bool> joinCampaignDialog(BuildContext context, Campaign campaign) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Join campaign?',
    content: campaign.description,
    optionsBuilder: () => {
      'no': false,
      'yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
