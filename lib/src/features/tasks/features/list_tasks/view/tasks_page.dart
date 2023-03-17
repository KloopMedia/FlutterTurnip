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

class TasksPage extends StatefulWidget {
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

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Future<void> createTask() async {
    try {
      final repository = context.read<GigaTurnipRepository>();
      if (widget.shouldJoinCampaign) {
        await repository.joinCampaign(widget.campaignId!);
      }
      final newTask = await repository.createTask(widget.createTaskId!);
      if (!mounted) return;
      context.go('/campaign/${widget.campaignId}/tasks/${newTask.id}');
    } catch (e) {
      print(e);
      context.go('/campaign/${widget.campaignId}');
    }
  }

  Future<dynamic> loadCampaign(BuildContext context) async {
    if (widget.campaignId != null) {
      final appBloc = context.read<AppBloc>();
      final repository = context.read<GigaTurnipRepository>();

      if (widget.shouldJoinCampaign) {
        await context.read<GigaTurnipRepository>().joinCampaign(widget.campaignId!);
      }

      final campaign = await repository.getCampaignById(widget.campaignId!);
      appBloc.add(AppSelectedCampaignChanged(campaign));
      return campaign;
    } else {
      return context.read<AppBloc>().state.selectedCampaign!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.createTaskId != null) {
      return Center(
        child: SizedBox(
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
            onPressed: () {
              createTask();
            },
            child: const Text(
              'Суу көйгөйү жөнүндө билдирүү / Рассказать о проблеме воды',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

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
            child: widget.simpleViewMode ? const CombinedTasksView() : const TasksView(),
          );
        } else {
          return TaskPage(taskId: snapshot.data);
        }
      },
    );
  }
}
