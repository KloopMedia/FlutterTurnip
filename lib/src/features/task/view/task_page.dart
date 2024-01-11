import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart'; // hide Notification;
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
  void _redirectToCampaignDetail(BuildContext context) {
    context.pushNamed(
      CampaignDetailRoute.name,
      pathParameters: {'cid': '${widget.campaignId}'},
      extra: widget.campaign,
    );
  }

  //
  // @override
  // void initState() {
  //   if (!kIsWeb) {
  //     BackButtonInterceptor.add(myInterceptor);
  //   }
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   BackButtonInterceptor.remove(myInterceptor);
  //   super.dispose();
  // }
  //
  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   context.goNamed(CampaignRoute.name);
  //   return true;
  // }

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
              stageType: StageType.ac,
            ),
          )..initialize(),
        ),
        BlocProvider<ProactiveTasks>(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
              stageType: StageType.pr,
            ),
          )..initialize(),
        ),
        BlocProvider<ProactiveTasksButtons>(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: apiClient,
              campaignId: widget.campaignId,
              stageType: StageType.pb,
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
          )..initialize(query: {'completed': false}),
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
                    return Container(
                      width: 24,
                      height: 24,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(state.data.logo),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    );
                  } else {
                    return const Icon(Icons.info_outline);
                  }
                },
              ),
            ),
        ],
        actions: [NotificationButton(), SettingsButton()],
        floatingActionButton: TaskPageFloatingActionButton(campaignId: widget.campaignId),
        child: RelevantTaskPage(
          campaignId: widget.campaignId,
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
                const Positioned(
                  right: 12,
                  top: 5,
                  child: Icon(Icons.notifications_outlined),
                ),
                Align(
                  alignment: Alignment.topRight,
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
                              fontSize: 14.0, color: Theme.of(context).colorScheme.onPrimary)),
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
