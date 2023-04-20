import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../bloc/campaign_cubit.dart';
import 'campaign_view.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({Key? key}) : super(key: key);

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectableCampaignCubit>(
          create: (context) => CampaignCubit(
            SelectableCampaignRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
            ),
          )..initialize(),
        ),
        BlocProvider<UserCampaignCubit>(
          create: (context) => CampaignCubit(
            UserCampaignRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
            ),
          )..initialize(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: theme.background,
            drawerEnableOpenDragGesture: false,
            drawer: const AppDrawer(),
            body: Builder(
              builder: (context) {
                final formFactor = context.formFactor;

                if (formFactor == FormFactor.desktop) {
                  return Row(
                    children: const [
                      AppDrawer(),
                      Expanded(
                        child: CampaignView(),
                      )
                    ],
                  );
                } else {
                  return const CampaignView();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
