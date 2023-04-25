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
    context.goNamed(
      CampaignDetailRoute.name,
      params: {'cid': '${campaign.id}'},
      extra: campaign,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final color = theme.isLight ? Colors.white : theme.onSecondary;
    final double verticalPadding = (context.isDesktop || context.isTablet) ? 30 : 20;

    return CustomScrollView(
      slivers: [
        AdaptiveListView<Campaign, SelectableCampaignCubit>(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 24),
          mainAxisSpacing: 30,
          crossAxisSpacing: 20,
          crossAxisCount: 3,
          contentPadding: 10,
          itemBuilder: (context, index, item) {
            final cardBody = CardDescription(item.description);

            if (context.isDesktop || context.isTablet) {
              return CardWithChipAndTitle(
                tag: 'Placeholder',
                title: item.name,
                size: const Size.fromHeight(250),
                color: color,
                imageUrl: item.logo,
                flex: 1,
                onTap: () => redirectToCampaignDetail(context, item),
                body: cardBody,
              );
            } else {
              return CardWithChipAndTitle(
                tag: 'Placeholder',
                title: item.name,
                color: color,
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
