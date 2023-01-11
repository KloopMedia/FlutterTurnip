import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/important_notifications_cubit.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/index.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/combined_task_view.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TasksPage extends StatelessWidget {
  final int? campaignId;
  final bool simpleViewMode;
  final bool shouldJoinCampaign;

  const TasksPage({
    Key? key,
    this.campaignId,
    this.simpleViewMode = false,
    this.shouldJoinCampaign = false,
  }) : super(key: key);

  static Page page() => const MaterialPage<void>(child: TasksPage());

  Future<void> joinCampaign(BuildContext context, int id) async {
    await context.read<CampaignRepository>().joinCampaign(id);
  }

  Future<Campaign> loadCampaign(BuildContext context) async {
    if (campaignId != null) {
      if (shouldJoinCampaign) {
        joinCampaign(context, campaignId!);
      }
      final appBloc = context.read<AppBloc>();
      final campaign = await context.read<CampaignRepository>().getCampaignById(campaignId!);
      appBloc.add(AppSelectedCampaignChanged(campaign));
      return campaign;
    } else {
      return context.read<AppBloc>().state.selectedCampaign!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Campaign>(
      future: loadCampaign(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
      },
    );
  }
}
