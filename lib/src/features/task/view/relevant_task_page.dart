import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';
import 'relevant_task_notification.dart';
import 'relevant_task_view.dart';

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
      listener: (context, state) => handleReactiveTasksState(context, state, widget.campaignId),
      child: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
        builder: (context, campaignState) {
          if (campaignState is CampaignFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (campaignState is CampaignInitialized) {
            return BlocBuilder<TaskFilterCubit, TaskFilterState>(
              builder: (context, selectedVolumeState) {
                return RefreshIndicator(
                  onRefresh: () async => refreshAllTasks(context),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 27,
                        ),
                      ),
                      if (!closeNotificationCard)
                        buildImportantNotificationSliver(
                          context,
                          closeNotificationCardCallback: (id) async {
                            await closeNotificationCardMethod(context, id);
                            setState(() => closeNotificationCard = true);
                          },
                        ),
                      buildVolumesSliver(context),
                      ...buildClassicTaskPage(
                        context,
                        selectedVolumeState.volume,
                        campaignId: widget.campaignId,
                        onChainTap: (item, status) {
                          onChainTapMethod(context, item, status, widget.campaignId);
                        },
                      ),
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
}
