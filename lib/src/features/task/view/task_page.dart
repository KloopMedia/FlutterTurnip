import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            _redirectToCampaignPage(context);
          },
        ),
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
