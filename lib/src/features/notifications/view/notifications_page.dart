import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import '../cubit/notifications_cubit.dart';
import 'notifications_view.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
      create: (context) => NotificationsCubit(gigaTurnipRepository: context.read<GigaTurnipRepository>()),
      child: const NotificationsView()
    );
  }
}
