import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';


class AvailableCampaignView extends StatelessWidget {
  const AvailableCampaignView({Key? key}) : super(key: key);

  void redirectToCampaignDetail(BuildContext context, int id, Campaign campaign) {
    context.goNamed(
      CampaignDetailRoute.name,
      params: {'cid': '$id'},
      extra: campaign,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formFactor = context.formFactor;
    final theme = Theme.of(context).colorScheme;

    if (formFactor == FormFactor.desktop || formFactor == FormFactor.tablet) {
      return SliverGridViewWithPagination<Campaign, SelectableCampaignCubit>(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        crossAxisCount: 3,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index, item) {
          return CardWithChipAndTitle(
            size: const Size.fromHeight(250),
            tag: item.name,
            title: item.name,
            color: theme.isLight ? Colors.white : theme.onSecondary,
            imageUrl: item.logo,
            flex: 1,
            onTap: () => redirectToCampaignDetail(context, item.id, item),
            body: CardDescription(item.description),
          );
        },
      );
    } else {
      return SliverListViewWithPagination<Campaign, SelectableCampaignCubit>(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        itemBuilder: (context, index, item) {
          return CardWithChipAndTitle(
            tag: item.name,
            title: item.name,
            color: theme.isLight ? Colors.white : theme.onSecondary,
            imageUrl: item.logo,
            onTap: () => redirectToCampaignDetail(context, item.id, item),
            body: CardDescription(item.description),
          );
        },
      );
    }
  }
}
