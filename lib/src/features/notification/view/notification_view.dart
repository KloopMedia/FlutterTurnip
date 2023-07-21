import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../widgets/important_and_open_notification_listview.dart';

class NotificationView<NotificationCubit extends RemoteDataCubit<Notification>>
    extends StatelessWidget {
  final int campaignId;
  final bool isClosed;

  const NotificationView({Key? key, required this.campaignId, required this.isClosed}) : super(key: key);

  void redirectToNotification(BuildContext context, Notification notification) {
    context.pushNamed(
      NotificationDetailRoute.name,
      pathParameters: {
        'cid': '$campaignId',
        'nid': '${notification.id}',
      },
      extra: Notification,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<NotificationCubit>().refetch(),
      child: CustomScrollView(
        slivers: [
          (isClosed)
          ? SliverListViewWithPagination<Notification, NotificationCubit>(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            itemBuilder: (context, index, item) {
              return CardWithTitle(
                title: item.title,
                onTap: () => redirectToNotification(context, item),
              );
            },
          )
          : ImportantAndOpenNotificationListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            itemBuilder: (context, item) {
              return CardWithTitle(
                title: item.title,
                onTap: () => redirectToNotification(context, item),
              );
            },
          )
        ],
      ),
    );
  }
}
