import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';
import 'task_list_view.dart';

class RelevantTaskPage extends StatelessWidget {
  final int campaignId;

  const RelevantTaskPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OpenTaskBloc>(
          create: (context) => RelevantTaskBloc(
            OpenTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
        ),
        BlocProvider<ClosedTaskBloc>(
          create: (context) => RelevantTaskBloc(
            ClosedTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
        ),
      ],
      child: TaskView(
        campaignId: campaignId,
      ),
    );
  }
}

class TaskView extends StatelessWidget {
  final int campaignId;

  const TaskView({Key? key, required this.campaignId}) : super(key: key);

  void redirect(BuildContext context, int taskId) {
    context.goNamed(
      Constants.taskDetailRoute.name,
      params: {
        'cid': '$campaignId',
        'tid': '$taskId',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TaskListView(
            bloc: context.read<OpenTaskBloc>(),
            header: const Text('Open tasks'),
            onTap: (task) {
              redirect(context, task.id);
            },
          ),
          TaskListView(
            bloc: context.read<ClosedTaskBloc>(),
            header: const Text('Closed tasks'),
            onTap: (task) {
              redirect(context, task.id);
            },
          ),
        ],
      ),
    );
  }
}
