import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../../bloc/bloc.dart';
import '../../../../router/routes/notification_route.dart';
import '../../../notification/bloc/notification_cubit.dart';
import '../relevant_task_widgets/relevant_task_navigation.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  void _redirectToNotificationPage(BuildContext context) async {
    final params = GoRouterState.of(context).pathParameters;
    final result = await context.pushNamed(NotificationRoute.name, pathParameters: params);

    if (context.mounted && result == true) {
      refreshAllTasks(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _redirectToNotificationPage(context),
      icon: BlocBuilder<OpenNotificationCubit, RemoteDataState<Notification>>(
        builder: (context, state) {
          if (state is RemoteDataLoaded<Notification>) {
            final notifications = state.data.where((item) => item.importance > 0).toList();
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topLeft,
              children: [
                Icon(Icons.notifications_outlined),
                if (notifications.isNotEmpty)
                  Positioned(
                    right: -12,
                    top: -5,
                    child: Container(
                      width: 22.0,
                      height: 20.0,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.tertiary),
                      child: Center(
                        child: Text(
                          (notifications.length > 10) ? '10+' : notifications.length.toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
