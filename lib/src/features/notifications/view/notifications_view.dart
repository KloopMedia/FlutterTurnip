import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/notifications/notifications.dart';
import 'package:gigaturnip/src/features/notifications/view/notification_view.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import '../cubit/notifications_cubit.dart';
import 'notifications_sliver_list_view.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  late String campaignName;

  @override
  void initState() {
    context.read<NotificationsCubit>().loadNotifications();
    campaignName = context.read<AppBloc>().state.selectedCampaign!.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.notifications),
      ),
      body: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state.status == NotificationsStatus.error) {
            showErrorDialog(context, state.errorMessage ?? context.loc.fetching_error);
          }
        },
        builder: (context, state) {
          if (state.status == NotificationsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          switch (state.selectedTab) {
            case Tabs.unreadNotificationsTab:
              return NotificationsSliverListView(
                  title: campaignName,
                  items: state.unreadNotifications,
                  onRefresh: () => context.read<NotificationsCubit>().loadNotifications(),
                  onTap: (notification) {
                    context.read<AppBloc>().add(AppSelectedNotificationChanged(notification));
                    context.read<NotificationsCubit>().onReadNotification(notification.id);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => NotificationView(notification: notification, campaignName: campaignName)))
                        .then((value) => context.read<NotificationsCubit>().loadNotifications());
                  }
              );
            case Tabs.readNotificationsTab:
              return NotificationsSliverListView(
                  title: campaignName,
                  items: state.readNotifications,
                  onRefresh: () => context.read<NotificationsCubit>().loadNotifications(),
                  onTap: (notification) {
                    context.read<AppBloc>().add(AppSelectedNotificationChanged(notification));
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => NotificationView(notification: notification, campaignName: campaignName)));
                  }
              );
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: const Icon(Icons.circle_notifications_outlined),
                  label: context.loc.unread_notifications
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.done_all),
                  label: context.loc.read_notifications
              )
            ],
            currentIndex: state.tabIndex,
            onTap: (index) {
              context.read<NotificationsCubit>().onTabChange(index);
              context.read<NotificationsCubit>().loadNotifications();
            },
          );
        },
      ),
    );
  }
}
