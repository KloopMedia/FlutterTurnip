import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/helpers/app_drawer.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:go_router/go_router.dart';

class CampaignPage extends StatelessWidget {
  const CampaignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiClient = context.read<api.GigaTurnipApiClient>();
    return BlocProvider(
      create: (_) => CampaignBloc(
        UserCampaignRepository(gigaTurnipApiClient: apiClient),
        SelectableCampaignRepository(gigaTurnipApiClient: apiClient),
      ),
      child: const CampaignView(),
    );
  }
}

class CampaignView extends StatelessWidget {
  const CampaignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: const AppDrawer(),
      body: BlocBuilder<CampaignBloc, CampaignState>(
        builder: (context, state) {
          if (state is CampaignFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CampaignLoaded) {
            return _CampaignListView(
              data: state.data,
              onTap: (campaign) => context.goNamed(
                Constants.taskRouteOpen.name,
                params: {'cid': '${campaign.id}'},
              ),
            );
          } else if (state is CampaignInfo) {
            return _CampaignInfoView(campaign: state.campaign);
          } else {
            return const Text('Error: Unknown state!');
          }
        },
      ),
    );
  }
}

class _CampaignListView extends StatelessWidget {
  final List<Campaign> data;
  final void Function(Campaign campaign) onTap;

  const _CampaignListView({Key? key, required this.data, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final campaign = data[index];
        return ListTile(
          title: Text(campaign.name),
          subtitle: Text('${campaign.id} ${campaign.canJoin}'),
          onTap: () {
            onTap(campaign);
          },
        );
      },
    );
  }
}

class _CampaignInfoView extends StatelessWidget {
  final Campaign campaign;

  const _CampaignInfoView({Key? key, required this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(campaign.description),
        if (campaign.canJoin)
          ElevatedButton(
            onPressed: () {},
            child: const Text('Yes'),
          ),
      ],
    );
  }
}
