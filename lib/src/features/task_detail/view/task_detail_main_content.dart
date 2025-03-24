import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/widgets/app_bar/new_scaffold_appbar.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../bloc/bloc.dart';
import '../util/util.dart';
import '../widgets/current_task_widget.dart';
import '../widgets/previous_task_widget.dart';
import '../widgets/release_button.dart';
import '../widgets/rich_text_button.dart';

/// Displays a detailed view of a single task (non-exercise), including previous tasks.
class TaskDetailMainContent extends StatefulWidget {
  final TaskDetail task;
  final List<TaskDetail> previousTasks;
  final int campaignId;

  const TaskDetailMainContent({
    super.key,
    required this.task,
    required this.previousTasks,
    required this.campaignId,
  });

  @override
  State<TaskDetailMainContent> createState() => _TaskDetailMainContentState();
}

class _TaskDetailMainContentState extends State<TaskDetailMainContent> {
  final ScrollController _scrollController = ScrollController();
  late final TaskBloc bloc = context.read<TaskBloc>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppbar(
      title: Text(
        widget.task.name,
        overflow: TextOverflow.ellipsis,
      ),
      leading: _buildBackButton(context),
      actions: [ReleaseButton(bloc: bloc, task: widget.task, campaignId: widget.campaignId)],
      child: RefreshIndicator(
        onRefresh: () async => bloc.add(RefetchTask()),
        child: _buildScrollableContent(context),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return BackButton(onPressed: () => navigateToTask(context, null, widget.campaignId));
  }

  Widget _buildScrollableContent(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      key: const PageStorageKey('TaskDetailMainContent'),
      child: Container(
        decoration: getTaskContainerDecoration(context),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: getTaskContainerMargin(context),
        child: Column(
          children: [
            if ((widget.task.stage.richText?.isNotEmpty ?? false)) RichTextButton(bloc: bloc),
            for (var prevTask in widget.previousTasks)
              PreviousTask(
                task: prevTask,
                pageStorageKey: const PageStorageKey('previousTask'),
              ),
            if (widget.previousTasks.isNotEmpty)
              const Divider(color: Colors.black, height: 36, thickness: 2),
            _buildCurrentTaskSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTaskSection(BuildContext context) {
    final state = bloc.state;
    final showAnswers = state is ShowAnswers;
    final redirect = showAnswers
        ? () => navigateToTask(context, (state as ShowAnswers).nextTaskId, widget.campaignId)
        : null;

    return CurrentTask(
      task: widget.task,
      pageStorageKey: const PageStorageKey('currentTask'),
      scrollController: _scrollController,
      showAnswers: showAnswers,
      redirect: redirect,
    );
  }
}
