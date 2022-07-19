import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import '../../../utilities/dialogs/error_dialog.dart';
import '../../app/app.dart';
import '../notifications.dart';
import 'notification_view.dart';
import 'notifications_list_view.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key, required this.campaignName}) : super(key: key);

  final String campaignName;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
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
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      color: Colors.purple[400],
                      child: Text(widget.campaignName, style: const TextStyle(fontSize: 18.0, color: Colors.white),),
                    ),
                NotificationsListView(
                    onTap: (notification) {
                      context.read<AppBloc>().add(AppSelectedNotificationChanged(notification));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationView(notification: notification, campaignName: widget.campaignName)));
                    },
                    onRefresh: () {
                      context.read<NotificationsCubit>().loadNotifications();
                    },
                    items: state.notifications
                ),
              ]
            );
        },
      ),
    );
  }
}