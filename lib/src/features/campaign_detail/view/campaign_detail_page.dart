import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/campaign_detail_bloc.dart';

class CampaignDetailPage extends StatelessWidget {
  final int campaignId;
  final Campaign? campaign;

  const CampaignDetailPage({
    Key? key,
    required this.campaignId,
    this.campaign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CampaignDetailBloc(
        repository: CampaignDetailRepository(
          gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
        ),
        campaignId: campaignId,
        campaign: campaign,
      )..add(InitializeCampaign()),
      child: const CampaignDetailView(),
    );
  }
}

class CampaignDetailView extends StatelessWidget {
  const CampaignDetailView({Key? key}) : super(key: key);

  void redirectToTaskMenu(BuildContext context, int id) {
    context.goNamed(
      Constants.relevantTaskRoute.name,
      params: {
        'cid': "$id",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CampaignDetailBloc, CampaignDetailState>(
        listener: (context, state) {
          if (state is CampaignJoinSuccess) {
            redirectToTaskMenu(context, state.data.id);
          }
        },
        builder: (context, state) {
          if (state is CampaignFetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CampaignFetchingError) {
            return Center(child: Text(state.error));
          }
          if (state is CampaignJoinError) {
            return Center(child: Text(state.error));
          }
          if (state is CampaignLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.data.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.data.description,
                    textAlign: TextAlign.center,
                  ),
                  if (state.data.canJoin)
                    ElevatedButton(
                      onPressed: () {
                        context.read<CampaignDetailBloc>().add(JoinCampaign());
                      },
                      child: const Text('Join'),
                    ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
