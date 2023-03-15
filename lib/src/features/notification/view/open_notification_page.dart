import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/notification/bloc/notification_bloc.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip/src/utilities/remote_data_type.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class OpenNotificationPage extends StatelessWidget {
  final int campaignId;

  const OpenNotificationPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OpenNotificationBloc>(
      create: (context) => NotificationBloc(
        OpenNotificationRepository(
          gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
          campaignId: campaignId,
        ),
      ),
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
        'tid': '${notification.id}',
      },
      extra: Notification,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListView(
      bloc: context.read<OpenNotificationBloc>(),
      onTap: (notification) {
        redirect(context, notification);
      },
    );
  }
}

class NotificationListView<NotificationBloc extends Bloc> extends StatelessWidget {
  final NotificationBloc bloc;
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
            if (state is RemoteDataFetching) {
              return const CircularProgressIndicator();
            }
            if (state is NotificationLoaded) {
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
              currentPage: state is NotificationInitialized ? state.currentPage : 0,
              total: state is NotificationInitialized ? state.total : 0,
              onChanged: (page) => bloc.add(RefetchNotificationData(page)),
              enabled: state is! RemoteDataFetching,
            );
          },
        )
      ],
    );
  }
}
