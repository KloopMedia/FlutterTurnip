import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/task_filter_bloc/task_filter_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/card/addons/card_with_title_and_task_notification.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/card/tag_with_icon_and title.dart';
import '../../notification/bloc/notification_cubit.dart';
import '../../notification/widgets/important_and_open_notification_listview.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';
import 'lesson_task_view.dart';

class RelevantTaskPage extends StatefulWidget {
  final int campaignId;

  const RelevantTaskPage({super.key, required this.campaignId});

  @override
  State<RelevantTaskPage> createState() => _RelevantTaskPageState();
}

class _RelevantTaskPageState extends State<RelevantTaskPage> {
  bool closeNotificationCard = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReactiveTasks, RemoteDataState<TaskStage>>(
      listener: _handleReactiveTasksState,
      child: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
        builder: (context, campaignState) {
          if (campaignState is CampaignFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (campaignState is CampaignInitialized) {
            return BlocBuilder<TaskFilterCubit, TaskFilterState>(
              builder: (context, selectedVolumeState) {
                return RefreshIndicator(
                  onRefresh: () async => _refreshAllTasks(context),
                  child: CustomScrollView(
                    slivers: [
                      if (!closeNotificationCard) _buildImportantNotificationSliver(context),
                      _buildVolumesSliver(context),
                      _buildContactUsButtonSliver(),
                      if (campaignState.data.newTaskViewMode)
                        ..._buildAlternativeTaskView(selectedVolumeState.volume)
                      else
                        ..._buildClassicTaskPage(context, selectedVolumeState.volume),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ----------------------------
  // State and Navigation Methods
  // ----------------------------
  void _handleReactiveTasksState(BuildContext context, RemoteDataState<TaskStage> state) {
    if (state is TaskCreated) {
      _redirectToTaskWithId(context, state.createdTaskId);
    } else if (state is TaskCreatingError) {
      _showTaskCreateErrorDialog(context, state.error);
    }
  }

  void _refreshAllTasks(BuildContext context) {
    context.read<CampaignDetailBloc>().add(RefreshCampaign());
    context.read<RelevantTaskCubit>().refetch();
    context.read<SelectableTaskStageCubit>().refetch();
    context.read<ReactiveTasks>().refetch();
    context.read<ProactiveTasks>().refetch();
    context.read<IndividualChainCubit>().refetch();
    context.read<OpenNotificationCubit>().refetch();
  }

  void _redirectToTask(BuildContext context, Task task) async {
    final result = await context.pushNamed<bool>(
      TaskDetailRoute.name,
      pathParameters: {
        'cid': '${widget.campaignId}',
        'tid': '${task.id}',
      },
      extra: task,
    );
    if (context.mounted && result == true) {
      _refreshAllTasks(context);
    }
  }

  void _redirectToTaskWithId(BuildContext context, int id) async {
    final result = await context.pushNamed<bool>(
      TaskDetailRoute.name,
      pathParameters: {
        'cid': '${widget.campaignId}',
        'tid': '$id',
      },
    );
    if (context.mounted && result == true) {
      _refreshAllTasks(context);
    }
  }

  void _redirectToAvailableTasks(BuildContext context, TaskStage stage) {
    context.goNamed(
      AvailableTaskRoute.name,
      pathParameters: {'cid': '${widget.campaignId}', 'tid': '${stage.id}'},
    );
  }

  void _onChainTap(TaskStageChainInfo item, ChainInfoStatus status) {
    if (status == ChainInfoStatus.notStarted) {
      context.read<ReactiveTasks>().createTaskById(item.id);
    } else {
      if (item.reopened.isNotEmpty) {
        _redirectToTaskWithId(context, item.reopened.first);
      } else if (item.opened.isNotEmpty) {
        _redirectToTaskWithId(context, item.opened.first);
      } else if (item.completed.isNotEmpty) {
        _redirectToTaskWithId(context, item.completed.first);
      } else {
        context.read<ReactiveTasks>().createTaskById(item.id);
      }
    }
  }

  Future<void> _redirectToNotification(BuildContext context, Notification notification) async {
    final result = await context.pushNamed<bool>(
      NotificationDetailRoute.name,
      pathParameters: {
        'cid': '${widget.campaignId}',
        'nid': '${notification.id}',
      },
      extra: Notification,
    );
    if (context.mounted && result == true) {
      context.read<OpenNotificationCubit>().refetch();
    }
  }

  // ---------------------------
  // UI Building Helper Methods
  // ---------------------------
  Widget _buildImportantNotificationSliver(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final notificationStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: theme.isLight ? theme.onSurfaceVariant : theme.neutral80,
      overflow: TextOverflow.ellipsis,
    );

    return ImportantAndOpenNotificationListView(
      padding: const EdgeInsets.only(top: 15.0, left: 24, right: 24),
      importantNotificationCount: 1,
      itemBuilder: (context, item) {
        return CardWithTitle(
          chips: [
            TagWithIconAndTitle(
              context.loc.important_notification,
              icon: Image.asset(
                'assets/images/important_notification_icon.png',
                color: theme.isLight ? const Color(0xFF5E80FB) : const Color(0xFF9BB1FF),
              ),
            ),
            IconButton(
              onPressed: () => _closeNotificationCard(context, item.id),
              icon: Icon(
                Icons.close,
                color: theme.isLight ? theme.onSurfaceVariant : theme.neutralVariant70,
              ),
            ),
          ],
          hasBoxShadow: false,
          title: item.title,
          backgroundColor: theme.isLight ? theme.primaryContainer : theme.surfaceVariant,
          size: context.isSmall || context.isMedium ? null : const Size(400, 165),
          flex: context.isSmall || context.isMedium ? 0 : 1,
          onTap: () => _redirectToNotification(context, item),
          body: Text(item.text, style: notificationStyle, maxLines: 3),
        );
      },
    );
  }

  Widget _buildVolumesSliver(BuildContext context) {
    return Volumes(
      onChanged: (Volume volume) {
        context.read<TaskFilterCubit>().setVolume(volume);
      },
    );
  }

  Widget _buildContactUsButtonSliver() {
    return const SliverToBoxAdapter(
      child: ContactUsButton(),
    );
  }

  List<Widget> _buildClassicTaskPage(BuildContext context, Volume? volume) {
    final theme = Theme.of(context).colorScheme;

    return [
      AvailableTaskStages(onTap: (item) => _redirectToAvailableTasks(context, item)),
      const CreatableTaskList(),
      if (volume?.showTagsFilter ?? true) const SliverToBoxAdapter(child: FilterBar()),
      _buildAdaptiveListViewForStages(context),
      _buildAdaptiveListViewForTasks(context, volume),
      TaskStageChainView(onTap: _onChainTap),
      const SliverToBoxAdapter(child: SizedBox(height: 20)),
    ];
  }

  List<Widget> _buildAlternativeTaskView(Volume? volume) {
    return [
      if (volume?.showTagsFilter ?? true) const SliverToBoxAdapter(child: FilterBar()),
      LessonTaskPage(onTap: _onChainTap),
    ];
  }

  Widget _buildAdaptiveListViewForStages(BuildContext context) {
    return AdaptiveListView<TaskStage, ReactiveTasks>(
      showLoader: false,
      padding: const EdgeInsets.only(top: 15.0, left: 24, right: 24),
      itemBuilder: (context, index, item) => CardWithTitle(
        chips: [
          CardChip(context.loc.creatable_task),
          const Spacer(),
          CardChip(
            context.loc.creatable_task_not_assigned,
            fontColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.neutral90,
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
            onPressed: () => context.read<ReactiveTasks>().createTask(item),
            child: Text(item.takeTaskButtonText ?? context.loc.creatable_task_assign_button),
          ),
        ),
      ),
    );
  }

  Widget _buildAdaptiveListViewForTasks(BuildContext context, Volume? volume) {
    final theme = Theme.of(context).colorScheme;

    return AdaptiveListView<Task, RelevantTaskCubit>(
      padding: const EdgeInsets.only(top: 15.0, left: 24, right: 24),
      itemBuilder: (context, index, item) {
        final cardBody = CardDate(date: item.createdAt?.toLocal());

        final openText =
            _getStatusText(volume?.activeTasksText, context.loc.task_status_not_submitted);
        final closedText =
            _getStatusText(volume?.completedTasksText, context.loc.task_status_submitted);
        final returnedText =
            _getStatusText(volume?.returnedTasksText, context.loc.task_status_returned);

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
                  chips: [CardChip(item.id.toString()), statusChip],
                  title: item.name,
                  contentPadding: 20,
                  size: context.isSmall || context.isMedium ? null : const Size.fromHeight(165),
                  flex: context.isSmall || context.isMedium ? 0 : 1,
                  onTap: () => _redirectToTask(context, item),
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

  // -----------------
  // Utility Methods
  // -----------------
  String _getStatusText(String? volumeText, String defaultText) {
    if (volumeText != null && volumeText.isNotEmpty) {
      return volumeText;
    }
    return defaultText;
  }

  void _closeNotificationCard(BuildContext context, int notificationId) async {
    final repo =
        NotificationDetailRepository(gigaTurnipApiClient: context.read<GigaTurnipApiClient>());
    await repo.markNotificationAsViewed(notificationId);
    setState(() => closeNotificationCard = true);
  }

  void _showTaskCreateErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => FormDialog(
        title: context.loc.form_error,
        content: error,
        buttonText: context.loc.ok,
      ),
    );
  }
}
