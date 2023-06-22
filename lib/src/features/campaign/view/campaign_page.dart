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
import '../bloc/language_bloc/language_cubit.dart';
import '../widgets/filter_bar_widget.dart';
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
  List<dynamic> queries = [];
  final Map<String, dynamic> queryMap = {};

  void onFilterTapByQuery(Map<String, dynamic> map) {
    context.read<UserCampaignCubit>().refetchWithFilter(map);
    context.read<SelectableCampaignCubit>().refetchWithFilter(map);
  }

  void addSelectedCategoryToQueries(Map<String, dynamic>? selectedCategory) {
    if (selectedCategory != null && selectedCategory.keys.first == 'Все') {
      queries.removeWhere((element) => element is Category);
      queryMap.removeWhere((key, value) => key == 'categories');
      onFilterTapByQuery(queryMap);
    } else if (selectedCategory != null && selectedCategory.keys.first != 'Все') {
      var category = Category(
          id: selectedCategory.values.first['categories'],
          name: selectedCategory.keys.first,
          outCategories: const []
      );
      queries.removeWhere((element) => element is Category);
      queries.add(category);
      queryMap.removeWhere((key, value) => key == 'categories');
      queryMap.addAll({'categories': category.id});
      onFilterTapByQuery(queryMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableCampaignCubit, RemoteDataState<Campaign>>(
      builder: (context, state) {
        final theme = Theme.of(context).colorScheme;
        return DefaultTabController(
          length: 2,
          child: SafeArea(
            child: DefaultAppBar(
              title: Text(context.loc.campaigns),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                FilterButton(
                  queries: queries,
                  onPressed: (selectedItems) {
                    queries.clear();
                    queryMap.clear();
                    if (selectedItems.isNotEmpty) {
                      for (var selectedItem in selectedItems) {
                        if (selectedItem is Country) {
                          queryMap.addAll({'countries__name': selectedItem.name});
                        } else if (selectedItem is Category) {
                          queryMap.addAll({'categories': selectedItem.id});
                        } else if (selectedItem is Language){
                          queryMap.addAll({'language__code': selectedItem.code});
                        }
                      }
                      queries.addAll(selectedItems);
                      onFilterTapByQuery(queryMap);
                    } else {
                      onFilterTapByQuery(queryMap);
                    }
                  },
                  openCloseFilter: (openClose) {
                    setState((){
                      showFilters = openClose;
                    });
                }),
              ],
              middle: FilterBarWidget(
                queries: queries,
                onChanged: (query) {
                  addSelectedCategoryToQueries(query!);
                },
              ),
              subActions: (showFilters)
                ? [
                  WebFilter<Country, CountryCubit>(
                    queries: queries,
                    title: context.loc.country,
                    onTap: (selectedItem) {
                      if (selectedItem != null) {
                        queries.removeWhere((item) => item is Country);
                        queries.add(selectedItem);
                        queryMap.addAll({'countries__name': selectedItem.name});
                        onFilterTapByQuery(queryMap);
                      } else {
                        queries.removeWhere((item) => item is Country);
                        queryMap.removeWhere((key, value) => key =='countries__name');
                        onFilterTapByQuery(queryMap);
                      }
                    },
                  ),
                  WebFilter<Category, CategoryCubit>(
                    queries: queries,
                    title: context.loc.category,
                    onTap: (selectedItem) {
                      if (selectedItem != null) {
                        queries.removeWhere((item) => item is Category);
                        queries.add(selectedItem);
                        queryMap.addAll({'categories': selectedItem.id});
                        onFilterTapByQuery(queryMap);
                      } else {
                        queries.removeWhere((item) => item is Category);
                        queryMap.removeWhere((key, value) => key == 'categories');
                        onFilterTapByQuery(queryMap);
                      }
                    },
                  ),
                  WebFilter<Language, LanguageCubit>(
                    queries: queries,
                    title: context.loc.language,
                    onTap: (selectedItem) {
                      if (selectedItem != null) {
                        queries.removeWhere((item) => item is Language);
                        queries.add(selectedItem);
                        queryMap.addAll({'language__code': selectedItem.code});
                        onFilterTapByQuery(queryMap);
                      } else {
                        queries.removeWhere((item) => item is Language);
                        queryMap.removeWhere((key, value) => key == 'language__code');
                        onFilterTapByQuery(queryMap);
                      }
                    },
                  ),
                ]
                : null,
              bottom: BaseTabBar(
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
                    child: Text(context.loc.open_campaigns, overflow: TextOverflow.ellipsis),
                  ),
                  Tab(
                    child: Text(context.loc.available_campaigns, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              child: const TabBarView(
                children: [
                  UserCampaignView(),
                  AvailableCampaignView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}