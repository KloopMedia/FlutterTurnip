import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/notification/bloc/notification_cubit.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class ClosedNotificationPage extends StatelessWidget {
  final int campaignId;

  const ClosedNotificationPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClosedNotificationCubit>(
      create: (context) => NotificationCubit(
        ClosedNotificationRepository(
          gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
          campaignId: campaignId,
        ),
      )..initialize(),
      child: NotificationView(campaignId: campaignId),
    );
  }
}

class NotificationView extends StatelessWidget {
  final int campaignId;

  const NotificationView({Key? key, required this.campaignId}) : super(key: key);

  void redirect(BuildContext context, Notification notification) {
    context.goNamed(
      Constants.notificationDetailRoute.name,
      params: {
        'cid': '$campaignId',
        'nid': '${notification.id}',
      },
      extra: Notification,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListView(
      bloc: context.read<ClosedNotificationCubit>(),
      onTap: (notification) {
        redirect(context, notification);
      },
    );
  }
}

class NotificationListView extends StatelessWidget {
  final ClosedNotificationCubit bloc;
  final void Function(Notification notification) onTap;

  const NotificationListView({Key? key, required this.bloc, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is RemoteDataLoading) {
              return const CircularProgressIndicator();
            }
            if (state is RemoteDataLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final notification = state.data[index];
                  return ListTile(
                    title: Text(notification.title),
                    subtitle: Text('${notification.id}'),
                    onTap: () => onTap(notification),
                  );
                },
                itemCount: state.data.length,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return Pagination(
              currentPage: state is RemoteDataInitialized ? state.currentPage : 0,
              total: state is RemoteDataInitialized ? state.total : 0,
              onChanged: (page) => bloc.fetchData(page),
              enabled: state is! RemoteDataLoading,
            );
          },
        )
      ],
    );
  }
}
