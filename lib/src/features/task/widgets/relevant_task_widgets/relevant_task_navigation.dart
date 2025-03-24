import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/bloc.dart';
import '../../../campaign_detail/bloc/campaign_detail_bloc.dart';
import '../../../notification/bloc/notification_cubit.dart';
import '../../bloc/bloc.dart';
import '../widgets.dart';

void refreshAllTasks(BuildContext context) {
  context.read<VolumeCubit>().refetch();
  context.read<CampaignDetailBloc>().add(RefreshCampaign());
  context.read<RelevantTaskCubit>().refetch();
  context.read<SelectableTaskStageCubit>().refetch();
  context.read<ReactiveTasks>().refetch();
  context.read<ProactiveTasks>().refetch();
  context.read<IndividualChainCubit>().refetch();
  context.read<OpenNotificationCubit>().refetch();
}

void redirectToTask(BuildContext context, int campaignId, Task task) async {
  final result = await context.pushNamed<bool>(
    TaskDetailRoute.name,
    pathParameters: {
      'cid': '$campaignId',
      'tid': '${task.id}',
    },
    extra: task,
  );
  if (context.mounted && result == true) {
    refreshAllTasks(context);
  }
}

void redirectToTaskWithId(BuildContext context, int campaignId, int id) async {
  final result = await context.pushNamed<bool>(
    TaskDetailRoute.name,
    pathParameters: {
      'cid': '$campaignId',
      'tid': '$id',
    },
  );
  if (context.mounted && result == true) {
    refreshAllTasks(context);
  }
}

void redirectToNotification(BuildContext context, Notification notification) async {
  final routeResult = await context.pushNamed<bool>(
    NotificationDetailRoute.name,
    pathParameters: {
      'cid': '', // Provide correct campaignId if needed
      'nid': '${notification.id}',
    },
    extra: Notification,
  );
  if (context.mounted && routeResult == true) {
    context.read<OpenNotificationCubit>().refetch();
  }
}

void redirectToAvailableTasks(BuildContext context, int campaignId, TaskStage stage) {
  context.goNamed(
    AvailableTaskRoute.name,
    pathParameters: {
      'cid': '$campaignId',
      'tid': '${stage.id}',
    },
  );
}

void onChainTapMethod(BuildContext context, TaskStageChainInfo item, ChainInfoStatus status, int campaignId) {
  if (status == ChainInfoStatus.notStarted) {
    context.read<ReactiveTasks>().createTaskById(item.id);
  } else {
    if (item.reopened.isNotEmpty) {
      redirectToTaskWithId(context, campaignId, item.reopened.first);
    } else if (item.opened.isNotEmpty) {
      redirectToTaskWithId(context, campaignId, item.opened.first);
    } else if (item.completed.isNotEmpty) {
      redirectToTaskWithId(context, campaignId, item.completed.first);
    } else {
      context.read<ReactiveTasks>().createTaskById(item.id);
    }
  }
}

void handleReactiveTasksState(BuildContext context, RemoteDataState<TaskStage> state, int campaignId) {
  if (state is TaskCreated) {
    redirectToTaskWithId(context, campaignId, state.createdTaskId);
  } else if (state is TaskCreatingError) {
    showTaskCreateErrorDialog(context, state.error);
  }
}

void createTask(BuildContext context, TaskStage item) {
  context.read<ReactiveTasks>().createTask(item);
}