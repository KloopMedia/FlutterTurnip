import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task_detail/bloc/task_bloc/task_bloc.dart';
import 'package:gigaturnip/src/features/task_detail/view/task_detail_view.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

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
    return BlocProvider(
      create: (context) => TaskBloc(
        repository: TaskDetailRepository(gigaTurnipApiClient: apiClient),
        campaignRepository: CampaignDetailRepository(gigaTurnipApiClient: apiClient),
        taskId: taskId,
        task: task,
      )..add(InitializeTask()),
      child: TaskDetailView(campaignId),
    );
  }
}
