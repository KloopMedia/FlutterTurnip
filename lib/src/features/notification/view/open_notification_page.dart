import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/notification/bloc/notification_cubit.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import 'notification_view.dart';

class OpenNotificationPage extends StatelessWidget {
  final int campaignId;

  const OpenNotificationPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OpenNotificationCubit>(
      create: (context) => NotificationCubit(
        OpenNotificationRepository(
          gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
          campaignId: campaignId,
        ),
      )..initialize(),
      child: NotificationView<OpenNotificationCubit>(campaignId: campaignId),
    );
  }
}
