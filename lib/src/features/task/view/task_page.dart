import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/selectable_task_stage_bloc/selectable_task_stage_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart' hide Notification;
import 'package:go_router/go_router.dart';

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
    final params = GoRouterState.of(context).params;
    context.goNamed(NotificationRoute.name, params: params);
  }

  void _redirectToCampaignDetail(BuildContext context) {
    context.pushNamed(
      CampaignDetailRoute.name,
      params: {'cid': '${widget.campaignId}'},
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
      ],
      child: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
        builder: (context, state) {
          if (state is CampaignInitialized) {
            return DefaultAppBar(
              // color: context.isSmall || context.isMedium ? appBarColor : null,
              boxShadow: context.isExtraLarge || context.isLarge ? Shadows.elevation1 : null,
              title: Text(state.data.name, overflow: TextOverflow.ellipsis, maxLines: 1),
              titleSpacing: 0,
              leading: [
                const SizedBox(width: 20),
                if (!context.isSmall || context.isMedium)
                  IconButton(
                    onPressed: () => _redirectToCampaignDetail(context),
                    icon: Builder(
                      builder: (context) {
                        if (state.data.logo.isNotEmpty) {
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
                  icon: const Icon(Icons.notifications_outlined),
                )
              ],
              floatingActionButton: TaskPageFloatingActionButton(campaignId: widget.campaignId),
              child: RelevantTaskPage(
                campaignId: widget.campaignId,
              ),
            );
          }
          if (state is CampaignFetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CampaignFetchingError) {
            return Center(child: Text(state.error));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
