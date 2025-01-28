import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/new_scaffold_appbar.dart';
import 'package:gigaturnip/src/widgets/error_box.dart';
import 'package:gigaturnip/src/widgets/slivers/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../campaign/bloc/campaign_cubit.dart';
import '../widget/featured_campaign_card.dart';

/// Shown after successful login, allows user to select featured campaigns or skip.
class OnBoardingView extends StatefulWidget {
  final BoxConstraints? constraints;

  const OnBoardingView({super.key, this.constraints});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldAppbar(
      child: SafeArea(
        child: FutureBuilder<List<Campaign>>(
          future: context.read<CampaignCubit>().fetchCampaigns(query: {'featured': true}),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _ErrorState(error: snapshot.error);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              final campaigns = snapshot.data ?? [];
              if (campaigns.isEmpty) {
                context.goNamed(CampaignRoute.name);
                return const SizedBox.shrink();
              }
              return _OnboardingContent(campaigns: campaigns);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

/// Local Component: Error State
class _ErrorState extends StatelessWidget {
  final Object? error;

  const _ErrorState({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: NetworkErrorBox(
        error as DioException,
        buttonText: context.loc.error_box_button_home,
        onPressed: () => context.goNamed(CampaignRoute.name),
      ),
    );
  }
}

/// Local Component: Onboarding Content
class _OnboardingContent extends StatelessWidget {
  final List<Campaign> campaigns;

  const _OnboardingContent({required this.campaigns});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: campaigns.length > 2 ? 110 : 190),
        _OnboardingHeader(fontColor: fontColor),
        Expanded(child: _CampaignGrid(campaigns: campaigns)),
        _SkipButton(),
        SizedBox(height: context.isSmall ? null : 50),
      ],
    );
  }
}

/// Local Component: Onboarding Header
class _OnboardingHeader extends StatelessWidget {
  final Color fontColor;

  const _OnboardingHeader({required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.loc.onboarding_header,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Local Component: Campaign Grid
class _CampaignGrid extends StatelessWidget {
  final List<Campaign> campaigns;

  const _CampaignGrid({required this.campaigns});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 500),
      child: CustomGridView(
        itemBuilder: (context, index, item) {
          return FeaturedCampaignCard(
            item: item,
            onTap: () => _handleCampaignSelection(context, item.id),
          );
        },
        crossAxisAlignment: CrossAxisAlignment.end,
        fillRow: campaigns.length == 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        items: campaigns,
        padding: const EdgeInsets.only(left: 24, right: 24, top: 65, bottom: 44),
      ),
    );
  }

  Future<void> _handleCampaignSelection(BuildContext context, int campaignId) async {
    final client = context.read<api.GigaTurnipApiClient>();
    final campaign = await client.getCampaignById(campaignId);

    if (!context.mounted) return;

    if (!campaign.isJoined) {
      await client.joinCampaign(campaignId);
      if (!context.mounted) return;
    }

    if (campaign.registrationStage != null) {
      await _handleRegistrationStage(context, campaignId, campaign.registrationStage!);
    } else {
      _navigateToTaskRoute(context, campaignId);
    }
  }

  Future<void> _handleRegistrationStage(BuildContext context, int campaignId, int stageId) async {
    final client = context.read<api.GigaTurnipApiClient>();
    try {
      final task = await client.createTaskFromStageId(stageId);
      if (context.mounted) {
        context.goNamed(
          TaskDetailRoute.name,
          pathParameters: {'cid': '$campaignId', 'tid': task.id.toString()},
        );
      }
    } catch (e) {
      debugPrint('Error creating task from stage: $e');
    }
  }

  void _navigateToTaskRoute(BuildContext context, int campaignId) {
    if (context.mounted) {
      context.goNamed(TaskRoute.name, pathParameters: {'cid': '$campaignId'});
    }
  }
}

/// Local Component: Skip Button
class _SkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: () => context.goNamed(CampaignRoute.name, extra: true),
      child: Text(
        context.loc.skip,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: theme.primary,
        ),
      ),
    );
  }
}
