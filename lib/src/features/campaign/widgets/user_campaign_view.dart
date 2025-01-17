import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/campaign/widgets/campaign_header.dart';
import 'package:gigaturnip/src/features/campaign/widgets/user_campaign_card.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../bloc/bloc.dart';
import '../bloc/campaign_cubit.dart';

class UserCampaignView extends StatelessWidget {
  const UserCampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCampaignCubit, RemoteDataState<Campaign>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Campaign>) {
          return MultiSliver(
            children: [
              CampaignHeader(
                title: context.loc.your_courses,
                padding: const EdgeInsets.fromLTRB(16, 21, 16, 11),
              ),
              _CampaignList(campaigns: state.data),
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

class _CampaignList extends StatelessWidget {
  final List<Campaign> campaigns;

  const _CampaignList({required this.campaigns});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemBuilder: (context, index) {
          final campaign = campaigns[index];
          return UserCampaignCard(campaign: campaign);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: campaigns.length,
      ),
    );
  }
}
