import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaigns/campaigns.dart';
import 'package:gigaturnip/src/features/home/home.dart';

class CampaignsView extends StatelessWidget {
  const CampaignsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CampaignsCubit>().loadCampaigns();
    return BlocConsumer<CampaignsCubit, CampaignsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
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
                // context.read<CampaignsCubit>().selectCampaign(context, campaign);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
              },
            );
          },
        );
      },
    );
  }
}
