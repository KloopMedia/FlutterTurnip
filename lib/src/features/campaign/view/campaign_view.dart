import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../bloc/campaign_cubit.dart';
import 'available_campaign_view.dart';
import 'user_campaign_view.dart';

class CampaignView extends StatelessWidget {
  const CampaignView({Key? key}) : super(key: key);

  double _calculateTabWidth(BuildContext context) {
    final formFactor = context.formFactor;
    final deviceWidth = MediaQuery.of(context).size.width;
    if (formFactor == FormFactor.desktop) {
      return deviceWidth / 3;
    } else if (formFactor == FormFactor.tablet) {
      return deviceWidth / 2;
    } else {
      return double.infinity;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final tabWidth = _calculateTabWidth(context);
    final state = context.read<SelectableCampaignCubit>().state;
    final hasAvailableCampaigns = state is RemoteDataLoaded<Campaign> && state.data.isNotEmpty;

    return Column(
      children: [
        BaseAppBar(
          iconTheme: IconThemeData(color: theme.isLight ? theme.neutral30 : theme.neutral90),
          backgroundColor: theme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          titleSpacing: context.formFactor == FormFactor.mobile ? 23 : 17,
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
            FilterButton(
              onPressed: () {},
            ),
          ],
          bottom: BaseTabBar(
            hidden: !hasAvailableCampaigns,
            width: tabWidth,
            border: context.formFactor == FormFactor.mobile
                ? Border(
                    bottom: BorderSide(
                      color: theme.isLight ? theme.neutralVariant80 : theme.neutralVariant40,
                      width: 2,
                    ),
                  )
                : null,
            tabs: [
              Tab(text: context.loc.available_campaigns),
              Tab(text: context.loc.campaigns),
            ],
          ),
        ),
        Expanded(
          child: hasAvailableCampaigns
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

class FilterButton extends StatelessWidget {
  final void Function()? onPressed;

  const FilterButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final formFactor = context.formFactor;

    if (formFactor == FormFactor.mobile) {
      return IconButton(onPressed: () {}, icon: const Icon(Icons.tune_rounded));
    } else {
      return OutlinedButton.icon(
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
      );
    }
  }
}
