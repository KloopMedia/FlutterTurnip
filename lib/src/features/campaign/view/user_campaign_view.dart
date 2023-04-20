import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import 'campaign_list_view.dart';

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
    return CampaignListView<Campaign, UserCampaignCubit>(
      onTap: (context, item) => redirectToTaskMenu(context, item),
      bodyBuilder: (item) => item.unreadNotifications > 0
          ? CardMessage('У вас ${item.unreadNotifications} непрочитанное сообщение')
          : null,
    );
  }
}
