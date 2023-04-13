import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/features/campaign/widgets/campaign_list_item.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../widgets/desktop/web_campaign_card/web_campaign_list_item.dart';

class AvailableCampaignPage extends StatelessWidget {
  const AvailableCampaignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SelectableCampaignCubit>(
      create: (context) => CampaignCubit(
        SelectableCampaignRepository(
          gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
        ),
      )..initialize(),
      child: const AvailableCampaignView(),
    );
  }
}

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
    return SliverListViewWithPagination<Campaign, SelectableCampaignCubit>(
      // padding: EdgeInsets.symmetric(vertical: 10.h), /// mobile
      padding: EdgeInsets.symmetric(horizontal: 10.h), /// desktop
      itemBuilder: (context, index, item) {
        // return CampaignListItem( /// mobile
        return WebCampaignListItem( /// desktop
          tag: 'Test tag',
          title: item.name,
          description: item.description,
          onTap: () => redirectToCampaignDetail(context, item.id, item),
        );
      },
    );
  }
}
