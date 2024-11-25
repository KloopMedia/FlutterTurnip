import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../widgets/app_bar/default_app_bar.dart';
import '../../../widgets/button/dialog/dialog_button_outlined.dart';
import '../../../widgets/dialogs/index.dart';
import '../bloc/bloc.dart';
import '../util/util.dart';
import '../widgets/current_task_widget.dart';
import '../widgets/previous_task_widget.dart';

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
  final _pageStorageKey = const PageStorageKey('pageKey');
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 0);

  late final bloc = context.read<TaskBloc>();

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      title: Text(widget.task.name, overflow: TextOverflow.ellipsis),
      automaticallyImplyLeading: false,
      leading: [
        BackButton(
          onPressed: () => navigateToTask(context, null, widget.campaignId),
        ),
      ],
      actions: [
        if (widget.task.stage.allowRelease)
          TextButton(
            onPressed: () {
              showTaskDialog(
                context,
                ReleaseTaskDialog(
                  onConfirm: () => bloc.add(ReleaseTask()),
                ),
              );
            },
            child: Text(context.loc.release_task_button),
          )
      ],
      child: RefreshIndicator(
        onRefresh: () async => bloc.add(RefetchTask()),
        child: SingleChildScrollView(
          controller: _scrollController,
          key: _pageStorageKey,
          child: Container(
            decoration: getTaskContainerDecoration(context),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: getTaskContainerMargin(context),
            child: Column(
              children: [
                if (widget.task.stage.richText?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: DialogButtonOutlined(
                      child: Text(context.loc.open_richtext),
                      onPressed: () => bloc.add(OpenTaskInfo()),
                    ),
                  ),
                for (final task in widget.previousTasks)
                  PreviousTask(task: task, pageStorageKey: _pageStorageKey),
                if (widget.previousTasks.isNotEmpty)
                  const Divider(color: Colors.black, height: 36, thickness: 2),
                CurrentTask(
                  task: widget.task,
                  pageStorageKey: _pageStorageKey,
                  scrollController: _scrollController,
                  showAnswers: bloc.state is ShowAnswers,
                  redirect: bloc.state is ShowAnswers
                      ? () => navigateToTask(
                          context, (bloc.state as ShowAnswers).nextTaskId, widget.campaignId)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
