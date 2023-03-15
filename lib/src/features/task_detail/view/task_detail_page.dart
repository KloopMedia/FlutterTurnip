import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task_detail/bloc/previous_task_bloc/previous_task_bloc.dart';
import 'package:gigaturnip/src/features/task_detail/bloc/task_bloc/task_bloc.dart';
import 'package:gigaturnip/src/helpers/webview/webview.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import 'previous_task_view.dart';
import 'task_detail_view.dart';

class TaskDetailPage extends StatelessWidget {
  final int taskId;
  final int campaignId;
  final Task? task;

  const TaskDetailPage({
    Key? key,
    required this.taskId,
    this.task,
    required this.campaignId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiClient = context.read<api.GigaTurnipApiClient>();
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => TaskBloc(
          repository: TaskDetailRepository(
            gigaTurnipApiClient: apiClient,
          ),
          taskId: taskId,
          task: task,
        ),
      ),
      BlocProvider(
        create: (context) => PreviousTaskBloc(
          repository: TaskDetailRepository(
            gigaTurnipApiClient: apiClient,
          ),
          taskId: taskId,
        ),
      ),
    ], child: TaskView(campaignId));
  }
}

class TaskView extends StatelessWidget {
  final int campaignId;

  const TaskView(this.campaignId, {Key? key}) : super(key: key);

  void redirect(BuildContext context, int? nextTaskId) {
    if (nextTaskId != null) {
      context.goNamed(
        Constants.taskDetailRoute.name,
        params: {
          'tid': '$nextTaskId',
          'cid': '$campaignId',
        },
      );
    } else {
      context.goNamed(
        Constants.relevantTaskRoute.name,
        params: {
          'cid': '$campaignId',
        },
      );
    }
  }

  void openWebView(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    final state = bloc.state as TaskInitialized;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebView(
          html: state.data.stage.richText,
          onCloseCallback: () {
            bloc.add(CloseTaskInfo());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<TaskBloc>().add(OpenTaskInfo());
            },
            icon: const Icon(Icons.text_snippet),
          )
        ],
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskSubmitted) {
            redirect(context, state.nextTaskId);
          }
          if (state is TaskClosed) {
            redirect(context, null);
          }
          if (state is TaskInfoOpened) {
            openWebView(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: const [
              PreviousTaskView(),
              TaskDetailView(),
            ],
          ),
        ),
      ),
    );
  }
}


