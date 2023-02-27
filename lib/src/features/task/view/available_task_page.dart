import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';
import 'task_list_view.dart';

class AvailableTaskPage extends StatelessWidget {
  final int campaignId;

  const AvailableTaskPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AvailableTaskBloc>(
          create: (context) => AvailableTaskBloc(
            AvailableTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
        ),
      ],
      child: TaskView(campaignId: campaignId),
    );
  }
}

class TaskView extends StatelessWidget {
  final int campaignId;

  const TaskView({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AvailableTaskBloc, AvailableTaskState>(
      listener: (context, state) {
        if (state is AvailableTaskRequestAssignmentSuccess) {
          context.goNamed(
            Constants.taskDetailRoute.name,
            params: {
              'cid': '$campaignId',
              'tid': '${state.task.id}',
            },
          );
        }
      },
      child: TaskListView(
        bloc: context.read<AvailableTaskBloc>(),
        header: const Text('Available tasks'),
        onTap: (task) {
          context.read<AvailableTaskBloc>().add(RequestAvailableTaskAssignment(task));
        },
      ),
    );
  }
}
