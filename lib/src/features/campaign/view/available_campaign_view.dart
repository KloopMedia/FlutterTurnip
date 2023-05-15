import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class AvailableCampaignView extends StatelessWidget {
  const AvailableCampaignView({Key? key}) : super(key: key);

  void redirectToCampaignDetail(BuildContext context, Campaign campaign) {
    context.pushNamed(
      CampaignDetailRoute.name,
      params: {'cid': '${campaign.id}'},
      extra: campaign,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = (context.isExtraLarge || context.isLarge) ? 30 : 20;

    return CustomScrollView(
      slivers: [
        AdaptiveListView<Campaign, SelectableCampaignCubit>(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 24),
          itemBuilder: (context, index, item) {
            final cardBody = CardDescription(item.description);

            if (context.isExtraLarge || context.isLarge) {
              return CardWithTitle(
                chips: const [CardChip('Placeholder')],
                title: item.name,
                size: const Size.fromHeight(250),
                imageUrl: item.logo,
                flex: 1,
                onTap: () => redirectToCampaignDetail(context, item),
                body: cardBody,
              );
            } else {
              return CardWithTitle(
                chips: const [CardChip('Placeholder')],
                title: item.name,
                imageUrl: item.logo,
                onTap: () => redirectToCampaignDetail(context, item),
                body: cardBody,
              );
            }
          },
        )
      ],
    );
  }
}
