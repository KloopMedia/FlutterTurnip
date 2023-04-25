import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class UserCampaignView extends StatelessWidget {
  const UserCampaignView({Key? key}) : super(key: key);

  void redirectToTaskMenu(BuildContext context, Campaign item) {
    context.goNamed(
      TaskRoute.name,
      params: {'cid': '${item.id}'},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final color = theme.isLight ? Colors.white : theme.onSecondary;
    final double verticalPadding = (context.isDesktop || context.isTablet) ? 30 : 20;

    return CustomScrollView(
      slivers: [
        AdaptiveListView<Campaign, UserCampaignCubit>(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 24),
          mainAxisSpacing: 30,
          crossAxisSpacing: 20,
          crossAxisCount: 3,
          contentPadding: 10,
          itemBuilder: (context, index, item) {
            final cardBody = item.unreadNotifications > 0
                ? CardMessage('У вас ${item.unreadNotifications} непрочитанное сообщение')
                : null;

            if (context.isDesktop || context.isTablet) {
              return CardWithChipAndTitle(
                tag: 'Placeholder',
                title: item.name,
                size: const Size.fromHeight(165),
                color: color,
                imageUrl: item.logo,
                flex: 1,
                onTap: () => redirectToTaskMenu(context, item),
                body: cardBody,
              );
            } else {
              return CardWithChipAndTitle(
                tag: 'Placeholder',
                title: item.name,
                color: color,
                imageUrl: item.logo,
                onTap: () => redirectToTaskMenu(context, item),
                body: cardBody,
              );
            }
          },
        ),
      ],
    );
  }
}
