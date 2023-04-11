import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../bloc/notification_cubit.dart';
import 'notification_view.dart';

class NotificationPage extends StatelessWidget {
  final int campaignId;

  const NotificationPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: context.loc.open_notification),
              Tab(text: context.loc.closed_notification),
            ],
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<OpenNotificationCubit>(
              create: (context) => NotificationCubit(
                OpenNotificationRepository(
                  gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
                  campaignId: campaignId,
                ),
              )..initialize(),
              child: NotificationView<OpenNotificationCubit>(campaignId: campaignId),
            ),
            BlocProvider<ClosedNotificationCubit>(
              create: (context) => NotificationCubit(
                ClosedNotificationRepository(
                  gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
                  campaignId: campaignId,
                ),
              )..initialize(),
              child: NotificationView<ClosedNotificationCubit>(campaignId: campaignId),
            ),
          ],
          child: TabBarView(
            children: [
              NotificationView<OpenNotificationCubit>(campaignId: campaignId),
              NotificationView<ClosedNotificationCubit>(campaignId: campaignId)
            ],
          ),
        ),
      ),
    );
  }
}
