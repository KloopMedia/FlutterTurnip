import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/widgets/available_task_stages.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/task_stage_chain_page.dart';
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
import '../widgets/creatable_task_list.dart';
import '../widgets/filter_bar.dart';
import '../widgets/task_chain/types.dart';

class RelevantTaskPage extends StatefulWidget {
  final int campaignId;

  const RelevantTaskPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  State<RelevantTaskPage> createState() => _RelevantTaskPageState();
}

class _RelevantTaskPageState extends State<RelevantTaskPage> {
  bool closeNotificationCard = false;

  void refreshAllTasks(BuildContext context) {
    context.read<RelevantTaskCubit>().refetch();
    context.read<SelectableTaskStageCubit>().refetch();
    context.read<ReactiveTasks>().refetch();
    context.read<ProactiveTasks>().refetch();
    context.read<IndividualChainCubit>().refetch();
  }

  void redirectToTask(BuildContext context, Task task) async {
    final result = await context.pushNamed<bool>(
      TaskDetailRoute.name,
      pathParameters: {
        'cid': '${widget.campaignId}',
        'tid': '${task.id}',
      },
      extra: task,
    );
    if (context.mounted && result != null && result) {
      refreshAllTasks(context);
    }
  }

  void redirectToTaskWithId(BuildContext context, int id) async {
    final result = await context.pushNamed<bool>(
      TaskDetailRoute.name,
      pathParameters: {
        'cid': '${widget.campaignId}',
        'tid': '$id',
      },
    );
    if (context.mounted && result != null && result) {
      refreshAllTasks(context);
    }
  }

  void redirectToAvailableTasks(BuildContext context, TaskStage stage) {
    context.goNamed(
      AvailableTaskRoute.name,
      pathParameters: {'cid': '${widget.campaignId}', 'tid': '${stage.id}'},
    );
  }

  void onChainTap(TaskStageChainInfo item, ChainInfoStatus status) async {
    if (status == ChainInfoStatus.notStarted) {
      context.read<ReactiveTasks>().createTaskById(item.id);
    } else {
      if (item.reopened.isNotEmpty) {
        redirectToTaskWithId(context, item.reopened.first);
      } else if (item.opened.isNotEmpty) {
        redirectToTaskWithId(context, item.opened.first);
      } else if (item.completed.isNotEmpty) {
        redirectToTaskWithId(context, item.completed.first);
      } else {
        context.read<ReactiveTasks>().createTaskById(item.id);
      }
    }
  }

  Future<void> redirectToNotification(BuildContext context, Notification notification) async {
    final result = await context.pushNamed<bool>(
      NotificationDetailRoute.name,
      pathParameters: {
        'cid': '${widget.campaignId}',
        'nid': '${notification.id}',
      },
      extra: Notification,
    );
    if (context.mounted && result != null && result) {
      context.read<OpenNotificationCubit>().refetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final notificationStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: theme.isLight ? theme.onSurfaceVariant : theme.neutral80,
      overflow: TextOverflow.ellipsis,
    );

    const taskFilterMap = {
      'Активные': {'complete': false},
      'Возвращенные': {'reopened': true, 'complete': false},
      'Отправленные': {'complete': true},
      'Все': null,
    };

    const individualChainFilterMap = {
      'Активные': {'completed': false},
      'Возвращенные': {'completed': false},
      'Отправленные': {'completed': true},
      'Все': null,
    };

    var filterNames = [
      context.loc.task_filter_active,
      context.loc.task_filter_returned,
      context.loc.task_filter_submitted,
      context.loc.task_filter_all,
    ];

    return BlocListener<ReactiveTasks, RemoteDataState<TaskStage>>(
      listener: (context, state) {
        if (state is TaskCreated) {
          redirectToTaskWithId(context, state.createdTaskId);
        }
        if (state is TaskCreatingError) {
          showDialog(
            context: context,
            builder: (context) => FormDialog(
              title: context.loc.form_error,
              content: state.error,
              buttonText: context.loc.ok,
            ),
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () async => refreshAllTasks(context),
        child: CustomScrollView(
          slivers: [
            // const SliverToBoxAdapter(
            //   child: PageHeader(padding: EdgeInsets.only(top: 20, bottom: 20)),
            // ),
            if (!closeNotificationCard)
              ImportantAndOpenNotificationListView(
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
                          onPressed: () async {
                            final repo = NotificationDetailRepository(
                                gigaTurnipApiClient: context.read<GigaTurnipApiClient>());
                            await repo.markNotificationAsViewed(item.id);
                            setState(() => closeNotificationCard = true);
                          },
                          icon: Icon(Icons.close,
                              color:
                                  theme.isLight ? theme.onSurfaceVariant : theme.neutralVariant70))
                    ],
                    hasBoxShadow: false,
                    title: item.title,
                    backgroundColor: theme.isLight ? theme.primaryContainer : theme.surfaceVariant,
                    size: context.isSmall || context.isMedium ? null : const Size(400, 165),
                    flex: context.isSmall || context.isMedium ? 0 : 1,
                    onTap: () => redirectToNotification(context, item),
                    body: Text(item.text, style: notificationStyle, maxLines: 3),
                  );
                },
              ),
            AvailableTaskStages(
              onTap: (item) => redirectToAvailableTasks(context, item),
            ),
            const CreatableTaskList(),
            SliverToBoxAdapter(
              child: FilterBar(
                title: context.loc.mytasks,
                onChanged: (query, key) {
                  context.read<RelevantTaskCubit>().refetchWithFilter(query: query);
                  context
                      .read<IndividualChainCubit>()
                      .refetchWithFilter(query: individualChainFilterMap[key]);
                },
                value: taskFilterMap.keys.first,
                filters: taskFilterMap,
                names: filterNames,
              ),
            ),
            AdaptiveListView<TaskStage, ReactiveTasks>(
              showLoader: false,
              padding: const EdgeInsets.only(top: 15.0, left: 24, right: 24),
              itemBuilder: (context, index, item) {
                return CardWithTitle(
                  chips: [
                    CardChip(context.loc.creatable_task),
                    const Spacer(),
                    CardChip(
                      context.loc.creatable_task_not_assigned,
                      fontColor: Colors.white,
                      backgroundColor: theme.neutral90,
                    )
                  ],
                  title: item.name,
                  size: context.isSmall || context.isMedium ? null : const Size.fromHeight(165),
                  flex: context.isSmall || context.isMedium ? 0 : 1,
                  bottom: Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () => context.read<ReactiveTasks>().createTask(item),
                        child: Text(
                          item.takeTaskButtonText ?? context.loc.creatable_task_assign_button,
                        ),
                      )),
                );
              },
            ),
            AdaptiveListView<Task, RelevantTaskCubit>(
              padding: const EdgeInsets.only(top: 15.0, left: 24, right: 24),
              itemBuilder: (context, index, item) {
                final cardBody = CardDate(date: item.createdAt?.toLocal());

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
                          chips: [CardChip(item.id.toString()), StatusCardChip(item)],
                          title: item.name,
                          contentPadding: 20,
                          size: context.isSmall || context.isMedium
                              ? null
                              : const Size.fromHeight(165),
                          flex: context.isSmall || context.isMedium ? 0 : 1,
                          onTap: () => redirectToTask(context, item),
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
            ),
            TaskStageChainView(onTap: onChainTap),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}
