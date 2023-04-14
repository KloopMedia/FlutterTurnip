import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/features/campaign/widgets/campaign_list_item_with_progress.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../desktop/web_campaign_list_item_with_progress.dart';
import '../desktop/sliver_grid_view_with_pagination.dart';

class UserCampaignView extends StatelessWidget {
  const UserCampaignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void redirectToTaskMenu(BuildContext context, int id) {
      context.goNamed(
        TaskRoute.name,
        params: {'cid': '$id'},
      );
    }

    /// mobile
    // return SliverListViewWithPagination<Campaign, UserCampaignCubit>(
    //   padding: EdgeInsets.symmetric(vertical: 10.h),
    //   itemBuilder: (context, index, item) {
    //     return CampaignListItemWithProgress(
    //       data: item,
    //       onTap: () => redirectToTaskMenu(context, item.id),
    //     );
    //   },
    // );

    /// desktop
    return SliverGridViewWithPagination<Campaign, UserCampaignCubit>(
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
      itemBuilder: (context, index, item) {
        return WebCampaignListItemWithProgress(
          data: item,
          onTap: () => redirectToTaskMenu(context, item.id),
        );
      },
    );

  }
}
