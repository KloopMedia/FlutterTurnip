import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../bloc/bloc.dart';
import '../../../router/routes/routes.dart';
import '../../../widgets/widgets.dart';
import '../bloc/campaign_cubit.dart';

class UserCampaignView extends StatelessWidget {
  const UserCampaignView({super.key});

  void redirectToTaskMenu(BuildContext context, Campaign item) {
    context.pushNamed(
      TaskRoute.name,
      pathParameters: {'cid': '${item.id}'},
      extra: item,
    );
  }

  Widget? campaignStatusWidget(BuildContext context, Campaign campaign) {
    Widget? chip;

    if (campaign.startDate != null) {
      final startDateString = DateFormat.MMMMd(context.loc.localeName).format(campaign.startDate!);
      chip = CardChip(
        context.loc.course_start_at(startDateString),
        fontColor: Colors.white,
        backgroundColor: Color(0xFF778CE0),
      );
    } else if (campaign.isCompleted) {
      chip = CardChip(
        context.loc.course_is_completed,
        fontColor: Colors.white,
        backgroundColor: Color(0xFF74BF3B),
      );
    }

    if (chip == null) {
      return null;
    }

    return Row(
      children: [chip],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<UserCampaignCubit, RemoteDataState<Campaign>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Campaign>) {
          return MultiSliver(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
                child: Text(
                  context.loc.your_courses,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.isLight ? theme.neutral30 : theme.neutral90,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final item = state.data[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? 0 : 10,
                        bottom: 10.0,
                        left: 24,
                        right: 24,
                      ),
                      child: CardWithTitle(
                        title: item.name,
                        body: SizedBox(
                          width: double.infinity,
                          child: Text(
                            item.description,
                            style: TextStyle(color: theme.onSurfaceVariant),
                          ),
                        ),
                        imageUrl: item.logo,
                        onTap: () => redirectToTaskMenu(context, item),
                        bottom: campaignStatusWidget(context, item),
                      ),
                    );
                  },
                  childCount: state.data.length,
                ),
              )
            ],
          );
        }

        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
