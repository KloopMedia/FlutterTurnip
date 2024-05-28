import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import 'card_chip.dart';

class StatusCardChip extends StatelessWidget {
  final Task item;
  final String? openText;
  final String? closedText;
  final String? returnedText;

  const StatusCardChip(this.item, {Key? key, this.openText, this.closedText, this.returnedText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? Colors.white : Colors.black;

    if (item.complete) {
      return CardChip(
        closedText ?? context.loc.task_status_submitted,
        fontColor: fontColor,
        backgroundColor: theme.statusGreen,
      );
    } else if (item.reopened) {
      return CardChip(
        returnedText ?? context.loc.task_status_returned,
        fontColor: fontColor,
        backgroundColor: theme.statusYellow,
      );
    } else {
      return CardChip(
        openText ?? context.loc.task_status_not_submitted,
        fontColor: fontColor,
        backgroundColor: theme.statusRed,
      );
    }
  }
}
