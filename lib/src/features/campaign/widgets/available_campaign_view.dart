import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/campaign/widgets/available_campaign_card.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../bloc/bloc.dart';
import '../bloc/campaign_cubit.dart';
import 'campaign_header.dart';

class AvailableCampaignView extends StatelessWidget {
  const AvailableCampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<UserCampaignCubit, RemoteDataState<Campaign>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Campaign> && state.data.isNotEmpty) {
          return MultiSliver(
            children: [
              CampaignHeader(
                title: context.loc.join_other_courses,
                padding: const EdgeInsets.fromLTRB(16, 21, 16, 16),
              ),
              _CampaignCarousel(campaigns: state.data, theme: theme),
            ],
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _CampaignCarousel extends StatelessWidget {
  final List<Campaign> campaigns;
  final ColorScheme theme;

  const _CampaignCarousel({
    required this.campaigns,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 146,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final campaign = campaigns[index];
          return AvailableCampaignCard(campaign: campaign);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: campaigns.length,
      ),
    );
  }
}
