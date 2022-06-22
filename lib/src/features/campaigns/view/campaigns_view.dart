import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/campaigns/campaigns.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

class CampaignsView extends StatelessWidget {
  const CampaignsView({Key? key}) : super(key: key);

  void _handleCampaignTap(BuildContext context, Campaign campaign) {
    context.read<AppBloc>().add(AppSelectedCampaignChanged(campaign));
    Navigator.of(context).pushNamed(tasksRoute);
  }

  @override
  Widget build(BuildContext context) {
    context.read<CampaignsCubit>().loadCampaigns();
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
        return RefreshIndicator(
          onRefresh: () async {
            context.read<CampaignsCubit>().loadCampaigns();
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.campaigns.length,
            itemBuilder: (context, index) {
              var campaign = state.campaigns[index];
              return ListTile(
                title: Text(
                  campaign.name,
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  _handleCampaignTap(context, campaign);
                },
              );
            },
          ),
        );
      },
    );
  }
}
