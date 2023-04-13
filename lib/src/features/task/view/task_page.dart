import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient, PaginationWrapper;
import 'package:gigaturnip_repository/gigaturnip_repository.dart' hide Notification;
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../bloc/bloc.dart';
import 'available_task_page.dart';
import 'relevant_task_page.dart';

class TaskPage extends StatefulWidget {
  final int campaignId;

  const TaskPage({
    Key? key,
    required this.campaignId,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int _currentIndex = 0;

  void _redirectToCampaignPage(BuildContext context) {
    final routeState = GoRouterState.of(context);
    context.goNamed(CampaignRoute.name, queryParams: routeState.queryParams);
  }

  void _redirectToNotificationPage(BuildContext context) {
    final params = GoRouterState.of(context).params;
    context.goNamed(NotificationRoute.name, params: params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            _redirectToCampaignPage(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _redirectToNotificationPage(context);
            },
            icon: FutureBuilder<PaginationWrapper>(
              future: context.read<GigaTurnipApiClient>().getUserNotifications(query: {
                'campaign': widget.campaignId,
                'viewed': false,
              }),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.count > 0) {
                  return Badge(
                    label: Text('${snapshot.data!.count}'),
                    child: const Icon(Icons.notifications),
                  );
                }
                return const Icon(Icons.notifications);
              },
            ),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<OpenTaskCubit>(
            create: (context) => RelevantTaskCubit(
              OpenTaskRepository(
                gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
                campaignId: widget.campaignId,
              ),
            )..initialize(),
          ),
          BlocProvider<ClosedTaskCubit>(
            create: (context) => RelevantTaskCubit(
              ClosedTaskRepository(
                gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
                campaignId: widget.campaignId,
              ),
            )..initialize(),
          ),
          BlocProvider(
            create: (context) => CreatableTaskCubit(
              CreatableTaskRepository(
                gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
                campaignId: widget.campaignId,
              ),
            )..initialize(),
          ),
          BlocProvider(
            create: (context) => AvailableTaskCubit(
              AvailableTaskRepository(
                gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
                campaignId: widget.campaignId,
              ),
            )..initialize(),
          ),
        ],
        child: Builder(
          builder: (context) {
            if (_currentIndex == 0) {
              return RelevantTaskPage(campaignId: widget.campaignId);
            }
            if (_currentIndex == 1) {
              return AvailableTaskPage(campaignId: widget.campaignId);
            }
            return Text('Unknown index $_currentIndex');
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.loc.relevant_tasks,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: context.loc.available_tasks,
          ),
        ],
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
      ),
    );
  }
}
