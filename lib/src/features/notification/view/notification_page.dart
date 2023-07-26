import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/tab_bar/base_tab_bar.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/notification_cubit.dart';
import 'notification_view.dart';

class NotificationPage extends StatefulWidget {
  final int campaignId;

  const NotificationPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
  //   redirectToTaskPage();
  //   return true;
  // }
  //
  void redirectToTaskPage() {
    context.goNamed(
      TaskRoute.name,
      pathParameters: {
        'cid': '${widget.campaignId}',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OpenNotificationCubit>(
          create: (context) => NotificationCubit(
            OpenNotificationRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: widget.campaignId,
            ),
          )..initialize(),
          child: NotificationView<OpenNotificationCubit>(campaignId: widget.campaignId, isClosed: false),
        ),
        BlocProvider<ClosedNotificationCubit>(
          create: (context) => NotificationCubit(
            ClosedNotificationRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: widget.campaignId,
            ),
          )..initialize(),
          child: NotificationView<ClosedNotificationCubit>(campaignId: widget.campaignId, isClosed: true),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: DefaultAppBar(
          automaticallyImplyLeading: false,
          leading: [BackButton(onPressed: redirectToTaskPage)],
          title: Text(context.loc.notifications),
          bottom: BaseTabBar(
            tabs: [
              Tab(child: Text(context.loc.open_notification, overflow: TextOverflow.ellipsis)),
              Tab(child: Text(context.loc.closed_notification, overflow: TextOverflow.ellipsis)),
            ],
          ),
          child: TabBarView(
            children: [
              NotificationView<OpenNotificationCubit>(campaignId: widget.campaignId, isClosed: false),
              NotificationView<ClosedNotificationCubit>(campaignId: widget.campaignId, isClosed: true),
            ],
          ),
        ),
      ),
    );
  }
}
