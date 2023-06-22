import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/widgets/available_task_stages.dart';
import 'package:gigaturnip/src/features/task/widgets/task_chain/task_stage_chain_page.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';
import '../widgets/filter_bar.dart';
import '../widgets/task_chain/types.dart';

class RelevantTaskPage extends StatefulWidget {
  final int campaignId;

  const RelevantTaskPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  State<RelevantTaskPage> createState() => _RelevantTaskPageState();
}

class _RelevantTaskPageState extends State<RelevantTaskPage> {
  void refreshAllTasks(BuildContext context, bool? refresh) {
    if (refresh ?? false) {
      context.read<RelevantTaskCubit>().refetch();
      context.read<SelectableTaskStageCubit>().refetch();
      context.read<ReactiveTasks>().refetch();
      context.read<ProactiveTasks>().refetch();
    }
  }

  void redirectToTask(BuildContext context, Task task) async {
    final result = await context.pushNamed<bool>(
      TaskDetailRoute.name,
      params: {
        'cid': '${widget.campaignId}',
        'tid': '${task.id}',
      },
      extra: task,
    );
    if (context.mounted) {
      refreshAllTasks(context, result);
    }
  }

  void redirectToTaskWithId(BuildContext context, int id) async {
    final result = await context.pushNamed<bool>(
      TaskDetailRoute.name,
      params: {
        'cid': '${widget.campaignId}',
        'tid': '$id',
      },
    );
    if (context.mounted) {
      refreshAllTasks(context, result);
    }
  }

  void redirectToAvailableTasks(BuildContext context, TaskStage stage) {
    context.goNamed(
      AvailableTaskRoute.name,
      params: {'cid': '${widget.campaignId}', 'tid': '${stage.id}'},
    );
  }

  void onChainTap(item, status) async {
    if (status == ChainInfoStatus.complete || status == ChainInfoStatus.active) {
      final repo = AllTaskRepository(
        gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
        campaignId: widget.campaignId,
      );
      final data = await repo.fetchAndParseData(query: {'stage': item.id});
      final task = data.results.where((element) => element.stage.id == item.id);
      if (!mounted) return;
      redirectToTaskWithId(context, task.first.id);
    } else {
      context.read<ReactiveTasks>().createTaskById(item.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = (context.isExtraLarge || context.isLarge) ? 30 : 20;

    const taskFilterMap = {
      'Активные': {'complete': false},
      'Возвращенные': {'reopened': true, 'complete': false},
      'Отправленные': {'complete': true},
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
      },
      child: CustomScrollView(
        slivers: [
          // const SliverToBoxAdapter(
          //   child: PageHeader(padding: EdgeInsets.only(top: 20, bottom: 20)),
          // ),
          AvailableTaskStages(
            onTap: (item) => redirectToAvailableTasks(context, item),
          ),
          SliverToBoxAdapter(
            child: FilterBar(
              title: context.loc.mytasks,
              onChanged: (query) {
                context.read<RelevantTaskCubit>().refetchWithFilter(query);
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
                title: item.name,
                size: context.isSmall || context.isMedium ? null : const Size.fromHeight(165),
                flex: context.isSmall || context.isMedium ? 0 : 1,
                onTap: () => context.read<ReactiveTasks>().createTask(item),
              );
            },
          ),
          AdaptiveListView<Task, RelevantTaskCubit>(
            padding: const EdgeInsets.only(top: 15.0, left: 24, right: 24),
            itemBuilder: (context, index, item) {
              final cardBody = CardDate(date: item.createdAt);

              return CardWithTitle(
                chips: [const Spacer(), StatusCardChip(item)],
                title: item.name,
                size: context.isSmall || context.isMedium ? null : const Size.fromHeight(165),
                flex: context.isSmall || context.isMedium ? 0 : 1,
                onTap: () => redirectToTask(context, item),
                bottom: cardBody,
              );
            },
          ),
          TaskStageChainView(onTap: onChainTap),
        ],
      ),
    );
  }
}