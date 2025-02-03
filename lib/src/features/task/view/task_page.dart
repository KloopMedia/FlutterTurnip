import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip/src/features/task/view/book_chain_view.dart';
import 'package:gigaturnip/src/features/task/view/relevant_task_page.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart'; // hide Notification;

import '../../../widgets/widgets.dart';
import '../../notification/bloc/notification_cubit.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class TaskPage extends StatefulWidget {
  final int campaignId;
  final Campaign? campaign;
  final bool? isTextbook;

  const TaskPage({
    super.key,
    required this.campaignId,
    this.campaign,
    this.isTextbook,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late bool _isBookView = widget.isTextbook ?? false;

  void handleTextBookViewModeChange(BuildContext context) {
    setState(() {
      _isBookView = !_isBookView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isGridView = context.isExtraLarge || context.isLarge;
    final apiClient = context.read<GigaTurnipApiClient>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CampaignDetailBloc(
            repository: CampaignDetailRepository(
              gigaTurnipApiClient: apiClient,
            ),
            campaignId: widget.campaignId,
            campaign: widget.campaign,
          )..add(InitializeCampaign()),
        ),
        BlocProvider(
          create: (context) => RelevantTaskCubit(
            AllTaskRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
              limit: isGridView ? 9 : 10,
            ),
          ),
        ),
        BlocProvider<ReactiveTasks>(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
              stageType: StageType.ac,
            ),
          ),
        ),
        BlocProvider<ProactiveTasks>(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
              stageType: StageType.pr,
            ),
          ),
        ),
        BlocProvider<ProactiveTasksButtons>(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
              stageType: StageType.pb,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SelectableTaskStageCubit(
            SelectableTaskStageRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => IndividualChainCubit(
            IndividualChainRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => BookChainCubit(
            BookChainRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
            ),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => VolumeCubit(
            VolumeRepository(gigaTurnipApiClient: apiClient, campaignId: widget.campaignId),
          )..initialize(query: {'limit': 50, 'track_fk__campaign': widget.campaignId}),
        ),
        BlocProvider<OpenNotificationCubit>(
          create: (context) => NotificationCubit(
            OpenNotificationRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: widget.campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => TaskFilterCubit(
            volumeSubscription: context.read<VolumeCubit>().stream,
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<TaskFilterCubit, TaskFilterState>(
            listener: (context, state) {
              final volumeId = state.volume?.id;
              final hasFilter = state.volume?.showTagsFilter ?? true;

              context.read<RelevantTaskCubit>().refetchWithFilter(
                query: {
                  if (hasFilter) ...?state.taskQuery,
                  'stage__volumes': volumeId,
                },
              );
              context.read<IndividualChainCubit>().refetchWithFilter(
                query: {
                  if (hasFilter) ...?state.chainQuery,
                  'stages__volumes': volumeId,
                },
              );
              context.read<BookChainCubit>().refetchWithFilter(
                query: {
                  'stages__volumes': volumeId,
                },
              );

              final stageQuery = {'volumes': volumeId};
              context.read<SelectableTaskStageCubit>().refetchWithFilter(query: stageQuery);
              context.read<ReactiveTasks>().refetchWithFilter(query: stageQuery);
              context.read<ProactiveTasks>().refetchWithFilter(query: stageQuery);
              context.read<ProactiveTasksButtons>().initialize(query: stageQuery);
            },
          ),
        ],
        child: Builder(builder: (context) {
          if (kIsWeb && (context.isLarge || context.isExtraLarge)) {
            return WebTaskPage(
              isBookView: _isBookView,
              campaignId: widget.campaignId,
              onTextBookViewChange: handleTextBookViewModeChange,
            );
          }

          return ScaffoldAppbar(
            title: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
              builder: (context, state) {
                if (state is CampaignInitialized) {
                  return Text(state.data.name, overflow: TextOverflow.ellipsis, maxLines: 1);
                }
                return const SizedBox.shrink();
              },
            ),
            actions: [
              NotificationButton(),
              IconButton(
                onPressed: () => handleTextBookViewModeChange(context),
                icon: Image.asset(
                  _isBookView ? 'assets/icon/book_closed.png' : 'assets/icon/book_open.png',
                  width: 24,
                  height: 24,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                ),
              )
            ],
            drawer: AppDrawer(),
            floatingActionButton: TaskPageFloatingActionButton(campaignId: widget.campaignId),
            child: Builder(builder: (context) {
              if (_isBookView) {
                return BookChainView();
              }
              return RelevantTaskPage(campaignId: widget.campaignId);
            }),
          );
        }),
      ),
    );
  }
}

class WebTaskPage extends StatefulWidget {
  final int campaignId;
  final bool isBookView;
  final void Function(BuildContext context) onTextBookViewChange;

  const WebTaskPage({
    super.key,
    required this.isBookView,
    required this.campaignId,
    required this.onTextBookViewChange,
  });

  @override
  State<WebTaskPage> createState() => _WebTaskPageState();
}

class _WebTaskPageState extends State<WebTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 304.0),
          child: ScaffoldAppbar(
            title: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
              builder: (context, state) {
                if (state is CampaignInitialized) {
                  return Text(state.data.name, overflow: TextOverflow.ellipsis, maxLines: 1);
                }
                return const SizedBox.shrink();
              },
            ),
            titleSpacing: 24,
            rounded: false,
            actions: [
              NotificationButton(),
              IconButton(
                onPressed: () => widget.onTextBookViewChange(context),
                icon: Image.asset(
                  widget.isBookView ? 'assets/icon/book_closed.png' : 'assets/icon/book_open.png',
                  width: 24,
                  height: 24,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                ),
              )
            ],
            floatingActionButton: TaskPageFloatingActionButton(campaignId: widget.campaignId),
            child: Builder(builder: (context) {
              if (widget.isBookView) {
                return BookChainView();
              }
              return RelevantTaskPage(campaignId: widget.campaignId);
            }),
          ),
        ),
        Container(
          color: Color(0xFFFEFBD2),
          child: AppDrawer(
            backgroundColor: const Color(0xFFFAFDFD),
          ),
        ),
      ],
    );
  }
}
