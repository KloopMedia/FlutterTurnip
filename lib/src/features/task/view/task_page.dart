import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/task_filter_bloc/task_filter_cubit.dart';
import 'package:gigaturnip/src/features/task/view/relevant_task_page.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/drawer/app_drawer.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart'; // hide Notification;
import 'package:go_router/go_router.dart';

import '../../../bloc/bloc.dart';
import '../../notification/bloc/notification_cubit.dart';
import '../bloc/bloc.dart';
import '../bloc/volume_bloc/volume_cubit.dart';
import '../widgets/task_page_floating_action_button.dart';

class TaskPage extends StatefulWidget {
  final int campaignId;
  final Campaign? campaign;

  const TaskPage({
    super.key,
    required this.campaignId,
    this.campaign,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  void _redirectToCampaignDetail(BuildContext context) {
    context.pushNamed(
      CampaignDetailRoute.name,
      pathParameters: {'cid': '${widget.campaignId}'},
      extra: widget.campaign,
    );
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

              context.read<RelevantTaskCubit>().refetchWithFilter(
                query: {
                  ...?state.taskQuery,
                  'stage__volumes': volumeId,
                },
              );
              context.read<IndividualChainCubit>().refetchWithFilter(
                query: {
                  ...?state.chainQuery,
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
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 48,
            title: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
              builder: (context, state) {
                if (state is CampaignInitialized) {
                  return Text(state.data.name, overflow: TextOverflow.ellipsis, maxLines: 1);
                }
                return const SizedBox.shrink();
              },
            ),
            centerTitle: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFEFBD2), Color(0xFFFECFB5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            titleSpacing: 0,
            leading: Builder(builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(Icons.menu),
              );
            }),
            leadingWidth: 64,
            actions: const [
              NotificationButton(),
              SizedBox(width: 12),
            ],
          ),
          drawer: AppDrawer(),
          floatingActionButton: TaskPageFloatingActionButton(campaignId: widget.campaignId),
          body: Container(
            padding: EdgeInsets.only(top: 9),
            decoration: BoxDecoration(
              color: Color(0xFFFECFB5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: RelevantTaskPage(campaignId: widget.campaignId),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
      builder: (context, state) {
        if (state is CampaignInitialized) {
          return IconButton(
            onPressed: () {
              final params = GoRouterState.of(context).pathParameters;
              context.pushNamed(SettingsRoute.name, pathParameters: params);
            },
            icon: const Icon(Icons.settings),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  void _redirectToNotificationPage(BuildContext context) {
    final params = GoRouterState.of(context).pathParameters;
    context.pushNamed(NotificationRoute.name, pathParameters: params);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _redirectToNotificationPage(context),
      icon: BlocBuilder<OpenNotificationCubit, RemoteDataState<Notification>>(
        builder: (context, state) {
          if (state is RemoteDataLoaded<Notification>) {
            final notifications = state.data.where((item) => item.importance > 0).toList();
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topLeft,
              children: [
                Icon(Icons.notifications_outlined),
                if (notifications.isNotEmpty)
                  Positioned(
                    right: -12,
                    top: -5,
                    child: Container(
                      width: 22.0,
                      height: 20.0,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.tertiary),
                      child: Center(
                        child: Text(
                          (notifications.length > 10) ? '10+' : notifications.length.toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
