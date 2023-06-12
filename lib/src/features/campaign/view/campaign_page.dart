import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../widgets/button/filter_button/web_filter/web_filter.dart';
import '../bloc/campaign_cubit.dart';
import '../bloc/category_bloc/category_cubit.dart';
import '../bloc/country_bloc/country_cubit.dart';
import '../bloc/filter_bloc/filter_bloc.dart';
import '../bloc/language_bloc/language_cubit.dart';
import 'available_campaign_view.dart';
import 'user_campaign_view.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({Key? key}) : super(key: key);

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  @override
  Widget build(BuildContext context) {
    final isGridView = context.isExtraLarge || context.isLarge;

    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectableCampaignCubit>(
          create: (context) => CampaignCubit(
            SelectableCampaignRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
              limit: isGridView ? 9 : 10,
            ),
          )..initialize(),
        ),
        BlocProvider<UserCampaignCubit>(
          create: (context) => CampaignCubit(
            UserCampaignRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
              limit: isGridView ? 9 : 10,
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(
            CategoryRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => CountryCubit(
            CountryRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(
            LanguageRepository(
              gigaTurnipApiClient: context.read<api.GigaTurnipApiClient>(),
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (_) => FilterBloc(),
        )
      ],
      child: const CampaignView(),
    );
  }
}
class CampaignView extends StatefulWidget {
  const CampaignView({Key? key}) : super(key: key);

  @override
  State<CampaignView> createState() => _CampaignViewState();
}

class _CampaignViewState extends State<CampaignView> {
  bool showFilters = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableCampaignCubit, RemoteDataState<Campaign>>(
      builder: (context, state) {
        final theme = Theme.of(context).colorScheme;
        final hasAvailableCampaigns = state is RemoteDataLoaded<Campaign> && state.data.isNotEmpty;
        final query = context.read<FilterBloc>().state.query;

        return DefaultTabController(
          length: 2,
          child: SafeArea(
            child: DefaultAppBar(
              title: Text(context.loc.campaigns),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                FilterButton(
                  onPressed: () {
                    context.read<SelectableCampaignCubit>().refetchWithFilter(query);
                    context.read<UserCampaignCubit>().refetchWithFilter(query);
                  },
                  openCloseFilter: (openClose) {
                    setState((){
                      showFilters = openClose;
                    });
                }),
              ],
              subActions: (showFilters)
                ? [
                  WebFilter<Country, CountryCubit>(
                    title: context.loc.country,
                  ),
                  WebFilter<Category, CategoryCubit>(
                    title: context.loc.category,
                  ),
                  WebFilter<Language, LanguageCubit>(
                    title: context.loc.language,
                  ),
                ]
                : null,
              bottom: BaseTabBar(
                hidden: !hasAvailableCampaigns,
                width: calculateTabWidth(context),
                border: context.formFactor == FormFactor.small
                    ? Border(
                        bottom: BorderSide(
                          color: theme.isLight ? theme.neutralVariant80 : theme.neutralVariant40,
                          width: 2,
                        ),
                      )
                    : null,
                tabs: [
                  Tab(
                    child: Text(context.loc.available_campaigns, overflow: TextOverflow.ellipsis),
                  ),
                  Tab(
                    child: Text(context.loc.campaigns, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              child: hasAvailableCampaigns
                  ? const TabBarView(
                      children: [
                        AvailableCampaignView(),
                        UserCampaignView(),
                      ],
                    )
                  : const UserCampaignView(),
            ),
          ),
        );
      },
    );
  }
}
