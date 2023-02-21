import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/utilities/dialogs/generic_dialog.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

Future<bool> joinCampaignDialog(BuildContext context, Campaign campaign) {
  return showGenericDialog<bool>(
    context: context,
    title: campaign.description,
    content: context.loc.join_campaign,
    optionsBuilder: () => {
      context.loc.no: false,
      context.loc.yes: true,
    },
  ).then(
    (value) => value ?? false,
  );
}
