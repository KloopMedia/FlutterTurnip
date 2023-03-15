import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/notification_detail/bloc/notification_detail_bloc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class NotificationDetailPage extends StatelessWidget {
  final int notificationId;
  final int campaignId;
  final Notification? notification;

  const NotificationDetailPage({
    Key? key,
    required this.notificationId,
    required this.campaignId,
    this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationDetailBloc(
        repository: NotificationDetailRepository(
          gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
        ),
        notificationId: notificationId,
        notification: notification,
      ),
      child: const NotificationDetailView(),
    );
  }
}

class NotificationDetailView extends StatelessWidget {
  const NotificationDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NotificationDetailBloc, NotificationDetailState>(
        listener: (context, state) {
          if (state is NotificationMarkingAsViewedError) {
            print(state.error);
          }
        },
        builder: (context, state) {
          if (state is NotificationFetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotificationFetchingError) {
            return Center(child: Text(state.error));
          }
          if (state is NotificationLoaded) {
            return Text(state.data.text);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
