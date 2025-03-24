import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../widgets/card/addons/card_with_title_and_task_notification.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';
import 'lesson_task_view.dart';

List<Widget> buildClassicTaskPage(
  BuildContext context,
  Volume? volume, {
  required int campaignId,
  required void Function(TaskStageChainInfo, ChainInfoStatus) onChainTap,
}) {
  return [
    const SliverToBoxAdapter(child: ContactUsButton()),
    AvailableTaskStages(
      onTap: (item) => redirectToAvailableTasks(context, campaignId, item),
    ),
    const CreatableTaskList(),
    if (volume?.showTagsFilter ?? true) const SliverToBoxAdapter(child: FilterBar()),
    buildAdaptiveListViewForStages(context),
    buildAdaptiveListViewForTasks(context, volume, campaignId),
    TaskStageChainView(onTap: onChainTap),
    const SliverToBoxAdapter(child: SizedBox(height: 30)),
  ];
}

List<Widget> buildAlternativeTaskView(
  Volume? volume, {
  required void Function(TaskStageChainInfo, ChainInfoStatus) onChainTap,
}) {
  return [
    if (volume?.showTagsFilter ?? true)
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: FilterBar(),
        ),
      ),
    const SliverToBoxAdapter(child: ContactUsButton()),
    LessonTaskPage(onTap: onChainTap),
  ];
}

Widget buildAdaptiveListViewForStages(BuildContext context) {
  final theme = Theme.of(context).colorScheme;

  return AdaptiveListView<TaskStage, ReactiveTasks>(
    showLoader: false,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemBuilder: (context, index, item) => CardWithTitle(
      chips: [
        CardChip(context.loc.creatable_task),
        const Spacer(),
        CardChip(
          context.loc.creatable_task_not_assigned,
          fontColor: Colors.white,
          backgroundColor: theme.neutral90,
        ),
      ],
      title: item.name,
      size: context.isSmall || context.isMedium ? null : const Size.fromHeight(165),
      flex: context.isSmall || context.isMedium ? 0 : 1,
      bottom: SizedBox(
        height: 40,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () => createTask(context, item),
          child: Text(item.takeTaskButtonText ?? context.loc.creatable_task_assign_button),
        ),
      ),
    ),
  );
}

Widget buildAdaptiveListViewForTasks(BuildContext context, Volume? volume, int campaignId) {
  final theme = Theme.of(context).colorScheme;

  return AdaptiveListView<Task, RelevantTaskCubit>(
    padding: const EdgeInsets.only(left: 16, right: 16),
    itemBuilder: (context, index, item) {
      final cardBody = CardDate(date: item.createdAt?.toLocal());

      final openText =
          getStatusText(volume?.activeTasksText, context.loc.task_status_not_submitted);
      final closedText =
          getStatusText(volume?.completedTasksText, context.loc.task_status_submitted);
      final returnedText =
          getStatusText(volume?.returnedTasksText, context.loc.task_status_returned);

      final statusChip = (volume?.showTags ?? true)
          ? StatusCardChip(item,
              openText: openText, closedText: closedText, returnedText: returnedText)
          : const SizedBox.shrink();

      return CardWithTitleAndTaskNotification(
        taskId: item.id,
        body: Container(
          decoration: BoxDecoration(
            color: theme.error,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              CardWithTitle(
                chips: [
                  CardChip(
                    item.id.toString(),
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.neutral40,
                    ),
                  ),
                  statusChip
                ],
                title: item.name,
                contentPadding: 20,
                size: context.isSmall || context.isMedium ? null : const Size.fromHeight(165),
                flex: context.isSmall || context.isMedium ? 0 : 1,
                onTap: () => redirectToTask(context, campaignId, item),
                bottom: cardBody,
              ),
              if (item.submittedOffline)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "The form wasn't sent due to a poor internet connection. Please resubmit the form when you have a stable connection.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

Widget buildVolumesSliver(BuildContext context) {
  return SliverToBoxAdapter(
    child: Volumes(
      onChanged: (Volume volume) {
        context.read<TaskFilterCubit>().setVolume(volume);
      },
    ),
  );
}
