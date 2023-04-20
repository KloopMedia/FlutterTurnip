import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import 'campaign_list_view.dart';

class AvailableCampaignView extends StatelessWidget {
  const AvailableCampaignView({Key? key}) : super(key: key);

  void redirectToCampaignDetail(BuildContext context, Campaign campaign) {
    context.goNamed(
      CampaignDetailRoute.name,
      params: {'cid': '${campaign.id}'},
      extra: campaign,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CampaignListView<Campaign, SelectableCampaignCubit>(
      onTap: (context, item) => redirectToCampaignDetail(context, item),
      bodyBuilder: (item) => CardDescription(item.description),
    );
  }
}
