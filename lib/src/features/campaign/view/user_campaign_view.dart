import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/features/campaign/view/empty_campaign_page.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class UserCampaignView extends StatelessWidget {
  const UserCampaignView({Key? key}) : super(key: key);

  void redirectToTaskMenu(BuildContext context, Campaign item) {
    context.pushNamed(
      TaskRoute.name,
      params: {'cid': '${item.id}'},
    );
  }

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = (context.isExtraLarge || context.isLarge) ? 30 : 20;

    return CustomScrollView(
      slivers: [
        AdaptiveListView<Campaign, UserCampaignCubit>(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 24),
          emptyPlaceholder: const EmptyCampaignPage(
            title: 'Пока что здесь пусто',
            body:
                'Здесь Вы найдете кампании к которым Вы присоединились. Присоединиться к кампании Вы можете  в разделе "Все кампании"',
          ),
          itemBuilder: (context, index, item) {
            final cardBody = item.unreadNotifications > 0
                ? CardMessage('У вас ${item.unreadNotifications} непрочитанное сообщение')
                : null;

            if (context.isExtraLarge || context.isLarge) {
              return CardWithTitle(
                title: item.name,
                size: const Size.fromHeight(165),
                imageUrl: item.logo,
                flex: 1,
                onTap: () => redirectToTaskMenu(context, item),
                body: cardBody,
              );
            } else {
              return CardWithTitle(
                title: item.name,
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
