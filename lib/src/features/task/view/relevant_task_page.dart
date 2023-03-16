import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/helpers/list_view_with_pagination.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';

class RelevantTaskPage extends StatelessWidget {
  final int campaignId;

  const RelevantTaskPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OpenTaskCubit>(
          create: (context) => RelevantTaskCubit(
            OpenTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider<ClosedTaskCubit>(
          create: (context) => RelevantTaskCubit(
            ClosedTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
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

  void redirectToTask(BuildContext context, Task task) {
    context.goNamed(
      TaskDetailRoute.name,
      params: {
        'cid': '$campaignId',
        'tid': '${task.id}',
      },
      extra: task,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListViewWithPagination<Task, OpenTaskCubit>(
            header: const Text('Open tasks'),
            itemBuilder: (context, index, item) {
              return ListTile(
                title: Text(item.name),
                subtitle: Text("${item.id} | complete: ${item.complete}"),
                onTap: () => redirectToTask(context, item),
              );
            },
          ),
          ListViewWithPagination<Task, ClosedTaskCubit>(
            header: const Text('Closed tasks'),
            itemBuilder: (context, index, item) {
              return ListTile(
                title: Text(item.name),
                subtitle: Text("${item.id} | complete: ${item.complete}"),
                onTap: () => redirectToTask(context, item),
              );
            },
          ),
        ],
      ),
    );
  }
}
