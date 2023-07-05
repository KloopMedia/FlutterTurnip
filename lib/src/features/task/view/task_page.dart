import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/selectable_task_stage_bloc/selectable_task_stage_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';// hide Notification;
import 'package:go_router/go_router.dart';

import '../../../bloc/bloc.dart';
import '../../notification/bloc/notification_cubit.dart';
import '../bloc/bloc.dart';
import '../widgets/task_page_floating_action_button.dart';
import 'relevant_task_page.dart';

class TaskPage extends StatefulWidget {
  final int campaignId;
  final Campaign? campaign;

  const TaskPage({
    Key? key,
    required this.campaignId,
    this.campaign,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  void _redirectToNotificationPage(BuildContext context) {
    final params = GoRouterState.of(context).pathParameters;
    context.pushNamed(NotificationRoute.name, pathParameters: params);
  }

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
    // final theme = Theme.of(context).colorScheme;
    // final appBarColor = theme.isLight
    //     ? const Color.fromRGBO(241, 243, 255, 1)
    //     : const Color.fromRGBO(40, 41, 49, 1);

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
          )..initialize(query: {'complete': false}),
        ),
        BlocProvider<ReactiveTasks>(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
              isProactive: false,
            ),
          )..initialize(),
        ),
        BlocProvider<ProactiveTasks>(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
              isProactive: true,
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => SelectableTaskStageCubit(
            SelectableTaskStageRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => IndividualChainCubit(
            IndividualChainRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider<OpenNotificationCubit>(
          create: (context) => NotificationCubit(
            OpenNotificationRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: widget.campaignId,
            ),
          )..initialize(),
        ),
      ],
      child: DefaultAppBar(
        // boxShadow: context.isExtraLarge || context.isLarge ? Shadows.elevation1 : null,
        title: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
          builder: (context, state) {
            if (state is CampaignInitialized) {
              return Text(state.data.name, overflow: TextOverflow.ellipsis, maxLines: 1);
            }
            return const SizedBox.shrink();
          },
        ),
        titleSpacing: 0,
        leading: [
          const SizedBox(width: 20),
          if (!context.isSmall || context.isMedium)
            IconButton(
              onPressed: () => _redirectToCampaignDetail(context),
              icon: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
                builder: (context, state) {
                  if (state is CampaignInitialized && state.data.logo.isNotEmpty) {
                    return Image.network(state.data.logo);
                  } else {
                    return const Icon(Icons.info_outline);
                  }
                },
              ),
            ),
        ],
        actions: [
          IconButton(
            onPressed: () => _redirectToNotificationPage(context),
            icon: BlocBuilder<OpenNotificationCubit, RemoteDataState<Notification>>(
              builder: (context, state) {
                if (state is RemoteDataInitialized<Notification>) {
                  final notifications = state.data;
                  return Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topLeft,
                    children: [
                      const Positioned(
                        right: 5,
                        top: 5,
                        child: Icon(Icons.notifications_outlined),
                      ),
                      if (notifications.isNotEmpty) Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            width: 18.0,
                            height: 18.0,
                            margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.tertiary
                            ),
                            child: Center(
                              child: Text(
                                  notifications.length.toString(),
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Theme.of(context).colorScheme.onPrimary)
                              ),
                            )
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          )
        ],
        floatingActionButton: TaskPageFloatingActionButton(campaignId: widget.campaignId),
        child: RelevantTaskPage(
          campaignId: widget.campaignId,
        ),
      ),
    );
  }
}
