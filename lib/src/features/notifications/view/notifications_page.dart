import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/notifications/notifications.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
        create: (context) => NotificationsCubit(
              selectedCampaign: context.read<AppBloc>().state.selectedCampaign!,
              gigaTurnipRepository: context.read<GigaTurnipRepository>(),
            ),
        child: const NotificationsView());
  }
}
