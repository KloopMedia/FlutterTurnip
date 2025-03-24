import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../util/util.dart';
import 'task_detail_exercise.dart';
import 'task_detail_main_content.dart';

/// A view that responds to [TaskBloc] states and displays the appropriate UI.
class TaskDetailView extends StatelessWidget {
  final int campaignId;

  const TaskDetailView({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) => _handleState(context, state),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is TaskInitialized) {
            return _buildInitializedState(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _handleState(BuildContext context, TaskState state) {
    if (state is TaskSubmitted) {
      navigateToTask(context, state.nextTaskId, campaignId);
    } else if (state is NotificationOpened) {
      showNotificationDialog(context, text: state.text, onPressed: () {
        context.read<TaskBloc>().add(CloseNotification(
          state.previousTasks, state.data, state.nextTaskId,
        ));
      });
    } else if (state is TaskClosed || state is TaskReleased) {
      navigateToTask(context, null, campaignId);
    } else if (state is TaskInfoOpened) {
      openWebView(
        context,
        state.data.stage.externalRendererUrl,
        state.data.stage.richText,
        state.data.stage.allowGoBack,
      );
    } else if (state is GoBackToPreviousTaskState) {
      navigateToTask(context, state.previousTaskId, campaignId);
    } else if (state is TaskReturned) {
      showTaskReturnedDialog(context, campaignId);
    } else if (state is FileDownloaded && !kIsWeb) {
      showFileDownloadedDialog(context, state.message);
    } else if (state is TaskErrorState) {
      showErrorDialog(context, state.error);
    } else if (state is RedirectToSms) {
      handleSmsRedirect(context, state.phoneNumber, state.data);
    }
  }

  Widget _buildInitializedState(BuildContext context, TaskInitialized state) {
    if (state.data.test != null) {
      return ExercisePage(
        test: state.data.test!,
        campaignId: campaignId,
        completed: state.data.complete,
      );
    }
    return TaskDetailMainContent(
      campaignId: campaignId,
      task: state.data,
      previousTasks: state.previousTasks,
    );
  }
}