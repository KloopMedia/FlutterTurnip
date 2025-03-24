import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/task_detail/bloc/task_bloc/task_bloc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'task_detail_view.dart';

/// A page that sets up and displays details of a specific task, providing a [TaskBloc] to its child.
class TaskDetailPage extends StatelessWidget {
  final int taskId;
  final int campaignId;
  final Task? task;

  const TaskDetailPage({
    super.key,
    required this.taskId,
    required this.campaignId,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _createTaskBloc(context),
      child: TaskDetailView(campaignId: campaignId),
    );
  }

  TaskBloc _createTaskBloc(BuildContext context) {
    final apiClient = context.read<api.GigaTurnipApiClient>();
    final repository = TaskDetailRepository(gigaTurnipApiClient: apiClient);
    final campaignRepository = CampaignDetailRepository(gigaTurnipApiClient: apiClient);

    return TaskBloc(
      repository: repository,
      campaignRepository: campaignRepository,
      taskId: taskId,
      task: task,
    )..add(InitializeTask());
  }
}