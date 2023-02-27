import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/important_notifications_cubit.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/index.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/combined_task_view.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> joinCampaign(BuildContext context, int id) async {
    await context.read<GigaTurnipRepository>().joinCampaign(id);
  }

  Future<dynamic> loadCampaign(BuildContext context) async {
    if (campaignId != null) {
      if (shouldJoinCampaign) {
        joinCampaign(context, campaignId!);
      }
      // Creating form page
      if (createTaskId != null) {
        final newTask = await context
            .read<GigaTurnipRepository>()
            .createTask(createTaskId!);
        context.go('/campaign/$campaignId/tasks/${newTask.id}');
        return newTask.id;
      }
      final appBloc = context.read<AppBloc>();
      final campaign = await context
          .read<GigaTurnipRepository>()
          .getCampaignById(campaignId!);
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
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data is Campaign) {
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
            child:
                simpleViewMode ? const CombinedTasksView() : const TasksView(),
          );
        } else {
          return TaskPage(taskId: snapshot.data!);
        }
      },
    );
  }
}
