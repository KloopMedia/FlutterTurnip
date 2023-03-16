import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/helpers/list_view_with_pagination.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';

class AvailableTaskPage extends StatelessWidget {
  final int campaignId;

  const AvailableTaskPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => AvailableTaskCubit(
            AvailableTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
        ),
      ],
      child: TaskView(campaignId: campaignId),
    );
  }
}

class TaskView extends StatelessWidget {
  final int campaignId;

  const TaskView({Key? key, required this.campaignId}) : super(key: key);

  void redirectToTask(BuildContext context, int id) {
    context.goNamed(
      TaskDetailRoute.name,
      params: {
        "cid": "$campaignId",
        "tid": "$id",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AvailableTaskCubit, RemoteDataState>(
          listener: (context, state) {
            if (state is AvailableTaskRequestAssignmentSuccess) {
              redirectToTask(context, state.task.id);
            }
          },
        ),
        BlocListener<CreatableTaskCubit, RemoteDataState>(
          listener: (context, state) {
            if (state is TaskCreating) {
              redirectToTask(context, state.createdTaskId);
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListViewWithPagination<TaskStage, CreatableTaskCubit>(
              itemBuilder: (context, index, item) {
                return ListTile(
                  title: Text(item.name),
                  onTap: () {
                    context.read<CreatableTaskCubit>().createTask(item);
                  },
                );
              },
            ),
            ListViewWithPagination<Task, AvailableTaskCubit>(
              header: const Text('Available tasks'),
              itemBuilder: (context, index, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.id.toString()),
                  onTap: () {
                    context.read<AvailableTaskCubit>().requestTaskAssignment(item);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
