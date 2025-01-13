import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../bloc/bloc.dart';
import '../../../router/routes/routes.dart';
import '../../../widgets/widgets.dart';
import '../bloc/campaign_cubit.dart';

class AvailableCampaignView extends StatelessWidget {
  const AvailableCampaignView({super.key});

  void redirectToCampaignDetail(BuildContext context, Campaign campaign) async {
    final client = context.read<api.GigaTurnipApiClient>();

    try {
      await client.joinCampaign(campaign.id);

      final registrationStage = campaign.registrationStage;

      if (registrationStage == null || !context.mounted) {
        _navigateToTaskRoute(context, campaign.id);
        return;
      }

      try {
        final task = await client.createTaskFromStageId(registrationStage);
        if (context.mounted) {
          _navigateToTaskDetail(context, campaign.id, task.id);
        }
      } catch (e) {
        print(e);
        _navigateToTaskRoute(context, campaign.id);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        content: Text("Error: $e"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _navigateToTaskDetail(BuildContext context, int campaignId, int taskId) {
    context.goNamed(TaskDetailRoute.name, pathParameters: {
      'cid': "$campaignId",
      'tid': taskId.toString(),
    });
  }

  void _navigateToTaskRoute(BuildContext context, int campaignId) {
    context.goNamed(TaskRoute.name, pathParameters: {
      'cid': "$campaignId",
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<SelectableCampaignCubit, RemoteDataState<Campaign>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Campaign> && state.data.isNotEmpty) {
          return MultiSliver(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
                child: Text(
                  context.loc.join_other_courses,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: theme.isLight ? theme.neutral30 : theme.neutral90,
                  ),
                ),
              ),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (context, index) {
                    final item = state.data[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: CardWithTitle(
                        title: item.name,
                        titleColor: Colors.black,
                        backgroundColor: Color(0xFFDCE1FF),
                        body: SizedBox(
                          height: 20,
                          width: double.infinity,
                          child: Text(
                            item.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        bottom: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: theme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => redirectToCampaignDetail(context, item),
                            child: Text(context.loc.join),
                          ),
                        ),
                        size: const Size(340, 150),
                        imageUrl: item.logo,
                        flex: 1,
                        onTap: () => redirectToCampaignDetail(context, item),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                  itemCount: state.data.length,
                ),
              )
            ],
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
