import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utilities/constants.dart';
import '../../../utilities/notification_services.dart';
import '../../../widgets/button/filter_button/web_filter/web_filter.dart';
import '../../../widgets/dialogs/selection_dialogs.dart';
import '../bloc/campaign_cubit.dart';
import '../bloc/category_bloc/category_cubit.dart';
import '../bloc/country_bloc/country_cubit.dart';
import '../bloc/language_bloc/language_cubit.dart';
import '../widgets/category_filter_bar_widget.dart';
import 'available_campaign_view.dart';
import 'user_campaign_view.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({Key? key}) : super(key: key);

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final isGridView = context.isExtraLarge || context.isLarge;
    final gigaTurnipApiClient = context.read<api.GigaTurnipApiClient>();
    notificationServices.getDeviceToken(gigaTurnipApiClient, null);

    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectableCampaignCubit>(
          create: (context) => CampaignCubit(
            SelectableCampaignRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
              limit: isGridView ? 9 : 10,
            ),
            context.read<SharedPreferences>(),
          )..initialize(),
        ),
        BlocProvider<UserCampaignCubit>(
          create: (context) => CampaignCubit(
            UserCampaignRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
              limit: isGridView ? 9 : 10,
            ),
            context.read<SharedPreferences>(),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(
            CategoryRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
            ),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => CountryCubit(
            CountryRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
            ),
            context.read<api.GigaTurnipApiClient>(),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(
            LanguageRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
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
  late SharedPreferences sharedPreferences;
  List<String>? selectedCountry = [];
  bool isDialogShown = false;
  bool showFilters = false;
  List<dynamic> queries = [];
  Map<String, dynamic> queryMap = {};

  void _onFilterTapByQuery(Map<String, dynamic> map) {
    context.read<UserCampaignCubit>().refetchWithFilter(query: map);
    context.read<SelectableCampaignCubit>().refetchWithFilter(query: map);
  }

  void _addSelectedCategoryToQueries(Map<String, dynamic>? selectedCategory) {
    if (selectedCategory != null && selectedCategory.keys.first == 'Все') {
      queries.removeWhere((element) => element is Category);
      queryMap.removeWhere((key, value) => key == 'categories');
      _onFilterTapByQuery(queryMap);
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
      _onFilterTapByQuery(queryMap);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final selectedCountry = sharedPreferences.getStringList(Constants.sharedPrefCountryKey);
    final firstTimeCountry = sharedPreferences.getBool(Constants.sharedPrefFirstTimeCountryKey);
    if (firstTimeCountry != null && firstTimeCountry) {
      isDialogShown = true;
      if (selectedCountry != null && selectedCountry.isNotEmpty) queries.add(Country(id: int.tryParse(selectedCountry[0])!, name: selectedCountry[1]));
    }
  }

  _searchBarDialog({
    required List data,
    required Function(List value) onSubmit,
  }) {
    if (context.isSmall) {
      showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        context: context,
        builder: (context) {
          return DropdownDialog(
            data: data,
            onSubmit: (value) {
              onSubmit(value);
            }
          );
        });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SearchBarDialog(
            data: data,
            onSubmit: (value) {
             onSubmit(value);
            }
          );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<CountryCubit>().loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (!isDialogShown) {
            Future.delayed(Duration.zero, () {
              _searchBarDialog(
                data: snapshot.data!,
                onSubmit: (selectedCountry) {
                  setState(() {
                    queries.add(Country(id: selectedCountry.first.id, name: selectedCountry.first.name));
                  });
                  sharedPreferences.setStringList(Constants.sharedPrefCountryKey, [selectedCountry.first.id.toString(), selectedCountry.first.name]);
                  sharedPreferences.setBool(Constants.sharedPrefFirstTimeCountryKey, true);
                  context.read<UserCampaignCubit>().refetchWithFilter(query: {'countries__name': selectedCountry.first.name});
                  context.read<SelectableCampaignCubit>().refetchWithFilter(query: {'countries__name': selectedCountry.first.name});
                }
              );
            });
            isDialogShown = true;
          }
        }

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
                                  sharedPreferences.setStringList(Constants.sharedPrefCountryKey, [selectedItem.id.toString(), selectedItem.name]);
                                } else if (selectedItem is Category) {
                                  queryMap.addAll({'categories': selectedItem.id});
                                } else if (selectedItem is Language){
                                  queryMap.addAll({'language__code': selectedItem.code});
                                }
                              }
                              queries.addAll(selectedItems);
                              _onFilterTapByQuery(queryMap);
                            } else {
                              sharedPreferences.setStringList(Constants.sharedPrefCountryKey, []);
                              _onFilterTapByQuery(queryMap);
                            }
                          },
                          openCloseFilter: (openClose) {
                            setState((){
                              showFilters = openClose;
                            });
                        }),
                      ],
                      middle: CategoryFilterBarWidget(
                        queries: queries,
                        onChanged: (query) {
                          _addSelectedCategoryToQueries(query!);
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
                                sharedPreferences.setStringList(Constants.sharedPrefCountryKey, [selectedItem.id.toString(), selectedItem.name]);
                                _onFilterTapByQuery(queryMap);
                              } else {
                                queries.removeWhere((item) => item is Country);
                                queryMap.removeWhere((key, value) => key =='countries__name');
                                sharedPreferences.setStringList(Constants.sharedPrefCountryKey, []);
                                _onFilterTapByQuery(queryMap);
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
                                _onFilterTapByQuery(queryMap);
                              } else {
                                queries.removeWhere((item) => item is Category);
                                queryMap.removeWhere((key, value) => key == 'categories');
                                _onFilterTapByQuery(queryMap);
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
                                _onFilterTapByQuery(queryMap);
                              } else {
                                queries.removeWhere((item) => item is Language);
                                queryMap.removeWhere((key, value) => key == 'language__code');
                                _onFilterTapByQuery(queryMap);
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
                            child: Text(context.loc.my_campaigns, overflow: TextOverflow.ellipsis),
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
    );
  }
}