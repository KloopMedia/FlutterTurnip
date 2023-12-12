import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/notification_detail/bloc/notification_detail_bloc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';

class NotificationDetailPage extends StatelessWidget {
  final int notificationId;
  final int campaignId;
  final Notification? notification;
  final RemoteMessage? message;

  const NotificationDetailPage({
    Key? key,
    required this.notificationId,
    required this.campaignId,
    this.notification,
    this.message,
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
      child: NotificationDetailView(campaignId: campaignId, message: message),
    );
  }
}

class NotificationDetailView extends StatefulWidget {
  final int campaignId;
  final RemoteMessage? message;

  const NotificationDetailView({
    Key? key,
    required this.campaignId,
    this.message,
  }) : super(key: key);

  @override
  State<NotificationDetailView> createState() => _NotificationDetailViewState();
}

class _NotificationDetailViewState extends State<NotificationDetailView> {
  // @override
  // void initState() {
  //   if (!kIsWeb) {
  //     BackButtonInterceptor.add(myInterceptor);
  //   }
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   BackButtonInterceptor.remove(myInterceptor);
  //   super.dispose();
  // }
  //
  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   redirectToNotificationPage();
  //   return true;
  // }
  //
  void redirectToNotificationPage() {
    if (context.canPop()) {
      context.pop(true);
    } else {
      context.goNamed(
        NotificationRoute.name,
        pathParameters: {
          'cid': '${widget.campaignId}',
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: redirectToNotificationPage,
        ),
      ),
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
            return Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        (widget.message?.notification == null) ? state.data.title : widget.message!.notification!.title!,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        (widget.message?.notification == null) ? state.data.text : widget.message!.notification!.body!,
                        textAlign: TextAlign.center
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
