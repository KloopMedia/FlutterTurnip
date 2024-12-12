import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../../../widgets/card/tag_with_icon_and_title.dart';
import '../../../widgets/widgets.dart';
import '../../notification/widgets/important_and_open_notification_listview.dart';
import '../widgets/relevant_task_widgets/relevant_task_navigation.dart';

Widget buildImportantNotificationSliver(
    BuildContext context, {
      required Future<void> Function(int id) closeNotificationCardCallback,
    }) {
  final theme = Theme.of(context).colorScheme;
  final notificationStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: theme.isLight ? theme.onSurfaceVariant : theme.neutral80,
    overflow: TextOverflow.ellipsis,
  );

  return ImportantAndOpenNotificationListView(
    padding: const EdgeInsets.only(top: 15.0, left: 24, right: 24),
    importantNotificationCount: 1,
    itemBuilder: (context, item) {
      return CardWithTitle(
        chips: [
          TagWithIconAndTitle(
            context.loc.important_notification,
            icon: Image.asset(
              'assets/images/important_notification_icon.png',
              color: theme.isLight ? const Color(0xFF5E80FB) : const Color(0xFF9BB1FF),
            ),
          ),
          IconButton(
            onPressed: () => closeNotificationCardCallback(item.id),
            icon: Icon(
              Icons.close,
              color: theme.isLight ? theme.onSurfaceVariant : theme.neutralVariant70,
            ),
          ),
        ],
        hasBoxShadow: false,
        title: item.title,
        backgroundColor: theme.isLight ? theme.primaryContainer : theme.surfaceVariant,
        size: context.isSmall || context.isMedium ? null : const Size(400, 165),
        flex: context.isSmall || context.isMedium ? 0 : 1,
        onTap: () => redirectToNotification(context, item),
        body: Text(item.text, style: notificationStyle, maxLines: 3),
      );
    },
  );
}