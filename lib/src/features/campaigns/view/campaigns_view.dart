import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/campaigns/campaigns.dart';
import 'package:gigaturnip/src/features/campaigns/view/campaigns_list_view.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import 'package:gigaturnip/src/utilities/dialogs/join_campaign_dialog.dart';
import 'package:go_router/go_router.dart';

class CampaignsView extends StatefulWidget {
  final bool simpleViewMode;
  const CampaignsView({Key? key, required this.simpleViewMode}) : super(key: key);

  @override
  State<CampaignsView> createState() => _CampaignsViewState();
}

class _CampaignsViewState extends State<CampaignsView> {
  late final query = widget.simpleViewMode ? '?simple=true' : '';

  @override
  initState() {
    context.read<CampaignsCubit>().loadCampaigns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CampaignsCubit, CampaignsState>(
      listener: (context, state) {
        if (state.status == CampaignsStatus.error) {
          showErrorDialog(context, state.errorMessage ?? context.loc.fetching_error);
        }
      },
      builder: (context, state) {
        if (state.status == CampaignsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return CampaignsListView(
          onTap: (campaign, join) async {
            if (join) {
              final shouldJoin = await joinCampaignDialog(context);
              if (!mounted || !shouldJoin) return;
              await context.read<CampaignsCubit>().joinCampaign(campaign);
            }
            if (!mounted) return;
            context.read<AppBloc>().add(AppSelectedCampaignChanged(campaign));
            context.go('/campaign/${campaign.id}$query');
          },
          onRefresh: () {
            context.read<CampaignsCubit>().loadCampaigns(forceRefresh: true);
          },
          userCampaigns: state.campaigns,
          availableCampaigns: state.availableCampaigns,
        );
      },
    );
  }
}
