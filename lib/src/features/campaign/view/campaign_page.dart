import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/helpers/helpers.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class CampaignPage extends StatelessWidget {
  const CampaignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCampaignCubit>(
          create: (context) => CampaignCubit(
            UserCampaignRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
            ),
          )..initialize(),
        ),
        BlocProvider<SelectableCampaignCubit>(
          create: (context) => CampaignCubit(
            SelectableCampaignRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
            ),
          )..initialize(),
        )
      ],
      child: const CampaignView(),
    );
  }
}

class CampaignView extends StatelessWidget {
  const CampaignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void redirectToTaskMenu(BuildContext context, int id) {
      context.goNamed(
        TaskRelevantRoute.name,
        params: {'cid': '$id'},
      );
    }

    void redirectToCampaignDetail(BuildContext context, int id, Campaign campaign) {
      context.goNamed(
        CampaignDetailRoute.name,
        params: {'cid': '$id'},
        extra: campaign,
      );
    }

    return Scaffold(
      appBar: AppBar(),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListViewWithPagination<Campaign, UserCampaignCubit>(
              header: Text(context.loc.open_campaigns),
              itemBuilder: (context, index, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text("${item.id}"),
                  onTap: () => redirectToTaskMenu(context, item.id),
                );
              },
            ),
            ListViewWithPagination<Campaign, SelectableCampaignCubit>(
              header: Text(context.loc.available_campaigns),
              itemBuilder: (context, index, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text("${item.id}"),
                  onTap: () => redirectToCampaignDetail(context, item.id, item),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
