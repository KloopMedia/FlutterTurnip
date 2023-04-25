import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart' hide Notification;

import '../bloc/bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    final isGridView = context.isDesktop || context.isTablet;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CampaignDetailBloc(
            repository: CampaignDetailRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
            ),
            campaignId: widget.campaignId,
            campaign: widget.campaign,
          )..add(InitializeCampaign()),
        ),
        BlocProvider(
          create: (context) => RelevantTaskCubit(
            AllTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: widget.campaignId,
              limit: isGridView ? 9 : 10,
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: widget.campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => AvailableTaskCubit(
            AvailableTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: widget.campaignId,
            ),
          )..initialize(),
        ),
      ],
      child: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
        builder: (context, state) {
          if (state is CampaignInitialized) {
            return DefaultAppBar(
              title: Text(state.data.name),
              leading: [
                if ((context.isDesktop || context.isTablet) & state.data.logo.isNotEmpty)
                  IconButton(onPressed: () {}, icon: Image.network(state.data.logo))
              ],
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
