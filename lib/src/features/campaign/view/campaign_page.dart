import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../bloc/campaign_cubit.dart';
import 'available_campaign_view.dart';
import 'user_campaign_view.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({Key? key}) : super(key: key);

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  bool showTabs = false;

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
      child: BlocListener<SelectableCampaignCubit, RemoteDataState<Campaign>>(
        listener: (context, state) {
          if (state is RemoteDataLoaded<Campaign>) {
            setState(() {
              showTabs = state.data.isNotEmpty;
            });
          }
        },
        child: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: theme.background,
              drawer: const AppDrawer(),
              body: Builder(
                builder: (context) {
                  final formFactor = context.formFactor;

                  if (formFactor == FormFactor.desktop) {
                    return DesktopView(showTabs: showTabs);
                  } else if (formFactor == FormFactor.tablet) {
                    return TabletView(showTabs: showTabs);
                  } else {
                    return MobileView(showTabs: showTabs);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  final bool showTabs;

  const MobileView({Key? key, required this.showTabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      children: [
        BaseAppBar(
          iconTheme: IconThemeData(color: theme.isLight ? theme.neutral30 : theme.neutral90),
          backgroundColor: theme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          titleSpacing: 23,
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: Text(
            context.loc.campaigns,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              color: theme.isLight ? theme.neutral30 : theme.neutral90,
            ),
          ),
          actions: [
            // TODO: Replace icons
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.tune_rounded)),
          ],
          bottom: BaseTabBar(
            hidden: !showTabs,
            border: Border(
              bottom: BorderSide(
                color: theme.isLight ? theme.neutralVariant80 : theme.neutralVariant40,
                width: 2,
              ),
            ),
            tabs: [
              Tab(text: context.loc.available_campaigns),
              Tab(text: context.loc.campaigns),
            ],
          ),
        ),
        Expanded(
          child: showTabs
              ? const TabBarView(
                  children: [
                    AvailableCampaignView(),
                    UserCampaignView(),
                  ],
                )
              : const UserCampaignView(),
        ),
      ],
    );
  }
}

class TabletView extends StatelessWidget {
  final bool showTabs;

  const TabletView({Key? key, required this.showTabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      children: [
        BaseAppBar(
          iconTheme: IconThemeData(color: theme.isLight ? theme.neutral30 : theme.neutral90),
          backgroundColor: theme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          titleSpacing: 17,
          border: const Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: Text(
            context.loc.campaigns,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              color: theme.isLight ? theme.neutral30 : theme.neutral90,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17.5),
                side: BorderSide(color: theme.primary, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
              label: const Text('Фильтр'),
            )
          ],
          bottom: Row(
            children: [
              SizedBox(
                width: 360,
                child: BaseTabBar(
                  hidden: !showTabs,
                  tabs: [
                    Tab(text: context.loc.available_campaigns),
                    Tab(text: context.loc.campaigns),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: showTabs
              ? const TabBarView(
                  children: [
                    AvailableCampaignView(),
                    UserCampaignView(),
                  ],
                )
              : const UserCampaignView(),
        ),
      ],
    );
  }
}

class DesktopView extends StatelessWidget {
  final bool showTabs;

  const DesktopView({Key? key, required this.showTabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Row(
      children: [
        const AppDrawer(),
        Expanded(
          child: Column(
            children: [
              BaseAppBar(
                iconTheme: IconThemeData(color: theme.isLight ? theme.neutral30 : theme.neutral90),
                backgroundColor: theme.surface,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                titleSpacing: 17,
                border: const Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
                title: Text(
                  context.loc.campaigns,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: theme.isLight ? theme.neutral30 : theme.neutral90,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17.5),
                      side: BorderSide(color: theme.primary, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Фильтр'),
                  )
                ],
                bottom: Row(
                  children: [
                    SizedBox(
                      width: 360,
                      child: BaseTabBar(
                        hidden: !showTabs,
                        tabs: [
                          Tab(text: context.loc.available_campaigns),
                          Tab(text: context.loc.campaigns),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: showTabs
                    ? const TabBarView(
                        children: [
                          AvailableCampaignView(),
                          UserCampaignView(),
                        ],
                      )
                    : const UserCampaignView(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
