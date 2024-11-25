import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/task_detail/util/util.dart';
import 'package:gigaturnip/src/features/task_detail/view/exercise_page.dart';
import 'package:gigaturnip/src/features/task_detail/view/task_detail_main_content.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';

import '../bloc/bloc.dart';

class TaskDetailView extends StatelessWidget {
  final int campaignId;

  const TaskDetailView(this.campaignId, {super.key});

  void _handleState(BuildContext context, TaskState state) async {
    final bloc = context.read<TaskBloc>();

    if (state is TaskSubmitted) {
      navigateToTask(context, state.nextTaskId, campaignId);
    } else if (state is NotificationOpened) {
      showTaskDialog(
        context,
        FormDialog(
          title: context.loc.new_notification,
          content: state.text,
          buttonText: context.loc.got_it,
          onPressed: () =>
              bloc.add(CloseNotification(state.previousTasks, state.data, state.nextTaskId)),
        ),
      );
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
      // TODO: Decide if task should redirect to Tasks Page or to Reset Current Task.
      showTaskDialog(
        context,
        TaskReturnedDialog(
          onPop: () => navigateToTask(context, null, campaignId),
        ),
      );
    } else if (state is FileDownloaded && !kIsWeb) {
      showTaskDialog(
        context,
        FormDialog(content: state.message, buttonText: context.loc.ok),
      );
    } else if (state is TaskErrorState) {
      showTaskDialog(
        context,
        FormDialog(
          title: context.loc.form_error,
          content: state.error,
          buttonText: context.loc.ok,
        ),
      );
    } else if (state is RedirectToSms) {
      handleSmsRedirect(context, state.phoneNumber, state.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<TaskBloc>().add(RefetchTask()),
      child: BlocListener<TaskBloc, TaskState>(
        listener: _handleState,
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadingState) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is TaskInitialized) {
              if (state.data.test != null) {
                return ExercisePage(
                  test: state.data.test!,
                  campaignId: campaignId,
                );
              }
              return TaskDetailMainContent(
                campaignId: campaignId,
                task: state.data,
                previousTasks: state.previousTasks,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
