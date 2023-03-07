import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/important_notifications_cubit.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/index.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/combined_task_view.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../view_task/view/task_page.dart';

class TasksPage extends StatelessWidget {
  final int? campaignId;
  final bool simpleViewMode;
  final bool shouldJoinCampaign;
  final int? createTaskId;

  const TasksPage(
      {Key? key,
      this.campaignId,
      this.simpleViewMode = false,
      this.shouldJoinCampaign = false,
      this.createTaskId})
      : super(key: key);

  static Page page() => const MaterialPage<void>(child: TasksPage());

  Future<dynamic> loadCampaign(BuildContext context) async {
    if (campaignId != null) {
      final appBloc = context.read<AppBloc>();
      final repository = context.read<GigaTurnipRepository>();

      if (shouldJoinCampaign) {
        await context.read<GigaTurnipRepository>().joinCampaign(campaignId!);
      }

      if (createTaskId != null) {
        try {
          await Future.delayed(const Duration(seconds: 1));
          final newTask = await repository.createTask(createTaskId!);

          return newTask.id;
        } catch (e) {
          print(e);
        }
      }

      final campaign = await repository.getCampaignById(campaignId!);
      appBloc.add(AppSelectedCampaignChanged(campaign));
      return campaign;
    } else {
      return context.read<AppBloc>().state.selectedCampaign!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: loadCampaign(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data != null && snapshot.data is Campaign) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TasksCubit>(
                create: (context) => TasksCubit(
                  selectedCampaign: snapshot.data!,
                  gigaTurnipRepository: context.read<GigaTurnipRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => ImportantNotificationsCubit(
                  gigaTurnipRepository: context.read<GigaTurnipRepository>(),
                  selectedCampaign: snapshot.data!,
                ),
              ),
            ],
            child: simpleViewMode ? const CombinedTasksView() : const TasksView(),
          );
        } else {
          return TaskPage(taskId: snapshot.data);
        }
      },
    );
  }
}
