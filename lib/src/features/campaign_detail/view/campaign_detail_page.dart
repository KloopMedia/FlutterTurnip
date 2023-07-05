import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/shadows.dart';
import 'package:gigaturnip/src/theme/theme.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/index.dart';
import '../../../widgets/app_bar/default_app_bar.dart';
import '../../../widgets/widgets.dart';
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
      child: CampaignDetailView(campaignId: campaignId),
    );
  }
}

class CampaignDetailView extends StatelessWidget {
  final int campaignId;

  const CampaignDetailView({Key? key, required this.campaignId}) : super(key: key);

  void redirectToTaskMenu(BuildContext context, int id) {
    context.goNamed(
      TaskRoute.name,
      pathParameters: {
        'cid': "$id",
      },
    );
  }

  void redirectToCampaignPage(BuildContext context) {
    context.goNamed(CampaignRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultAppBar(
        automaticallyImplyLeading: false,
        title: const Text(''),
        leading: [
          IconButton(
            onPressed: () => context.canPop() ? context.pop() : redirectToCampaignPage(context),
            icon: const Icon(Icons.arrow_back_ios, size: 20),
          ),
        ],
        child: BlocConsumer<CampaignDetailBloc, CampaignDetailState>(
          listener: (context, state) async {
            if (state is CampaignJoinSuccess) {
              showDialog(context: context, builder: (context) => const JoinCampaignDialog())
                  .then((value) => redirectToTaskMenu(context, state.data.id));
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
              return Stack(
                children: [
                  _CampaignCard(data: state.data),
                  if (state.data.logo.isNotEmpty)
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(state.data.logo),
                      ),
                    ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final Campaign data;

  const _CampaignCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (context.isExtraLarge || context.isLarge) {
        return _Content(data: data);
      } else {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 50),
          decoration: const BoxDecoration(
            boxShadow: Shadows.elevation3,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: _Content(
              data: data,
              // context: context
            ),
          ),
        );
      }
    });
  }
}

class _Content extends StatelessWidget {
  final Campaign data;

  const _Content({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        children: [
          const SizedBox(height: 60),
          Text(
            data.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: theme.primary,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: theme.neutral40,
            ),
          ),
          (context.isExtraLarge || context.isLarge) ? const SizedBox(height: 40.0) : const Spacer(),
          if (data.canJoin)
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: SizedBox(
                width: (context.isSmall) ? double.infinity : 380,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    context.read<CampaignDetailBloc>().add(JoinCampaign());
                  },
                  child: Text(
                    context.loc.join_campaign,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
