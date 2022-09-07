import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/index.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/combined_task_view.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/view/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TasksPage extends StatelessWidget {
  final int? campaignId;
  final bool simpleViewMode;

  const TasksPage({Key? key, this.campaignId, this.simpleViewMode = false}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: TasksPage());

  Future<Campaign> loadCampaign(BuildContext context) async {
    if (campaignId != null) {
      final appBloc = context.read<AppBloc>();
      final campaign = await context.read<GigaTurnipRepository>().getCampaignById(campaignId!);
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
        return BlocProvider<TasksCubit>(
          create: (context) => TasksCubit(
            selectedCampaign: snapshot.data!,
            gigaTurnipRepository: context.read<GigaTurnipRepository>(),
          ),
          child: CombinedTasksView(),
        );
      },
    );
  }
}
