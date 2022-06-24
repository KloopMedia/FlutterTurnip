import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/campaigns/campaigns.dart';
import 'package:gigaturnip/src/features/campaigns/view/campaigns_list_view.dart';
import 'package:gigaturnip/src/utilities/dialogs/error_dialog.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

class CampaignsView extends StatefulWidget {
  const CampaignsView({Key? key}) : super(key: key);

  @override
  State<CampaignsView> createState() => _CampaignsViewState();
}

class _CampaignsViewState extends State<CampaignsView> {
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
          onTap: (campaign) {
            context.read<AppBloc>().add(AppSelectedCampaignChanged(campaign));
            Navigator.of(context).pushNamed(tasksRoute);
          },
          onRefresh: () {
            context.read<CampaignsCubit>().loadCampaigns(forceRefresh: true);
          },
          items: state.campaigns,
        );
      },
    );
  }
}
