import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import '../../../utilities/dialogs/error_dialog.dart';
import '../../app/app.dart';
import '../notifications.dart';
import 'notification_view.dart';
import 'notifications_list_view.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {

  @override
  void initState() {
    context.read<NotificationsCubit>().loadNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
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
          return NotificationsListView(
            onTap: (notification) {
              context.read<AppBloc>().add(AppSelectedNotificationChanged(notification));
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationView(notification: notification)));
              //Navigator.of(context).pushNamed(notificationsRoute);
            },
            onRefresh: () {
              context.read<NotificationsCubit>().loadNotifications();
            },
            items: state.notifications,
          );
      },
    );
  }

}