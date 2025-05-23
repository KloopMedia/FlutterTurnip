import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gigaturnip/src/features/notification_detail/bloc/notification_detail_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../router/routes/routes.dart';

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
      child: NotificationDetailView(campaignId: campaignId),
    );
  }
}

class NotificationDetailView extends StatefulWidget {
  final int campaignId;

  const NotificationDetailView({
    Key? key,
    required this.campaignId,
  }) : super(key: key);

  @override
  State<NotificationDetailView> createState() => _NotificationDetailViewState();
}

class _NotificationDetailViewState extends State<NotificationDetailView> {
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white,
                  child: SizedBox(
                    width: context.isSmall || context.isMedium
                        ? double.infinity
                        : MediaQuery.of(context).size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            state.data.title,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Linkify(
                            text: state.data.text,
                            textAlign: TextAlign.center,
                            onOpen: (link) async {
                              if (!await launchUrl(Uri.parse(link.url))) {
                                throw Exception('Could not launch ${link.url}');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
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
