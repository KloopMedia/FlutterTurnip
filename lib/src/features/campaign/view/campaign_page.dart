import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../router/routes/routes.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/notification_services.dart';
import '../../../widgets/button/filter_button/web_filter/web_filter.dart';
import '../../../widgets/dialogs/selection_dialogs.dart';
import '../bloc/campaign_cubit.dart';
import '../bloc/category_bloc/category_cubit.dart';
import '../bloc/country_bloc/country_cubit.dart';
import '../bloc/language_bloc/language_cubit.dart';

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
    final gigaTurnipApiClient = context.read<api.GigaTurnipApiClient>();
    notificationServices.getDeviceToken(gigaTurnipApiClient, null);

    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectableCampaignCubit>(
          create: (context) => CampaignCubit(
            SelectableCampaignRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
              limit: 30,
            ),
            context.read<SharedPreferences>(),
          )..initialize(),
        ),
        BlocProvider<UserCampaignCubit>(
          create: (context) => CampaignCubit(
            UserCampaignRepository(
              gigaTurnipApiClient: gigaTurnipApiClient,
              limit: 30,
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
          outCategories: const []);
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
      if (selectedCountry != null && selectedCountry.isNotEmpty)
        queries.add(Country(id: int.tryParse(selectedCountry[0])!, name: selectedCountry[1]));
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        context: context,
        builder: (context) {
          return DropdownDialog(
            data: data,
            onSubmit: (value) {
              onSubmit(value);
            },
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SearchBarDialog(
            data: data,
            onSubmit: (value) {
              onSubmit(value);
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<CountryCubit>().loadData(),
        builder: (context, snapshot) {
          /// comment until new countries appear
          // if (snapshot.hasData) {
          //   if (!isDialogShown) {
          //     Future.delayed(Duration.zero, () {
          //       _searchBarDialog(
          //         data: snapshot.data!,
          //         onSubmit: (selectedCountry) {
          //           setState(() {
          //             queries.add(Country(id: selectedCountry.first.id, name: selectedCountry.first.name));
          //           });
          //           sharedPreferences.setStringList(Constants.sharedPrefCountryKey, [selectedCountry.first.id.toString(), selectedCountry.first.name]);
          //           sharedPreferences.setBool(Constants.sharedPrefFirstTimeCountryKey, true);
          //           context.read<UserCampaignCubit>().refetchWithFilter(query: {'countries__name': selectedCountry.first.name});
          //           context.read<SelectableCampaignCubit>().refetchWithFilter(query: {'countries__name': selectedCountry.first.name});
          //         }
          //       );
          //     });
          //     isDialogShown = true;
          //   }
          // }

          return BlocBuilder<SelectableCampaignCubit, RemoteDataState<Campaign>>(
            builder: (context, state) {
              final theme = Theme.of(context).colorScheme;
              return DefaultAppBar(
                title: Text(context.loc.courses),
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
                              sharedPreferences.setStringList(Constants.sharedPrefCountryKey,
                                  [selectedItem.id.toString(), selectedItem.name]);
                            } else if (selectedItem is Category) {
                              queryMap.addAll({'categories': selectedItem.id});
                            } else if (selectedItem is Language) {
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
                        setState(() {
                          showFilters = openClose;
                        });
                      }),
                ],
                // middle: CategoryFilterBarWidget(
                //   queries: queries,
                //   onChanged: (query) {
                //     _addSelectedCategoryToQueries(query!);
                //   },
                // ),
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
                              sharedPreferences.setStringList(Constants.sharedPrefCountryKey,
                                  [selectedItem.id.toString(), selectedItem.name]);
                              _onFilterTapByQuery(queryMap);
                            } else {
                              queries.removeWhere((item) => item is Country);
                              queryMap.removeWhere((key, value) => key == 'countries__name');
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
                child: const CustomScrollView(
                  slivers: [
                    AvailableCampaignView(),
                    UserCampaignView(),
                  ],
                ),
              );
            },
          );
        });
  }
}

class UserCampaignView extends StatelessWidget {
  const UserCampaignView({super.key});

  void redirectToTaskMenu(BuildContext context, Campaign item) {
    context.pushNamed(
      TaskRoute.name,
      pathParameters: {'cid': '${item.id}'},
      extra: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<UserCampaignCubit, RemoteDataState<Campaign>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Campaign>) {
          return MultiSliver(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
                child: Text(
                  context.loc.your_courses,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: theme.isLight ? theme.neutral30 : theme.neutral90,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = state.data[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? 0 : 10,
                        bottom: 10.0,
                        left: 24,
                        right: 24,
                      ),
                      child: CardWithTitle(
                        title: item.name,
                        body: SizedBox(
                          width: double.infinity,
                          child: Text(
                            item.description,
                            style: TextStyle(color: theme.onSurfaceVariant),
                          ),
                        ),
                        imageUrl: item.logo,
                        onTap: () => redirectToTaskMenu(context, item),
                      ),
                    );
                  },
                  childCount: state.data.length,
                ),
              )
            ],
          );
        }

        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}

class AvailableCampaignView extends StatelessWidget {
  const AvailableCampaignView({super.key});

  void redirectToCampaignDetail(BuildContext context, Campaign campaign) async {
    final client = context.read<api.GigaTurnipApiClient>();

    try {
      await client.joinCampaign(campaign.id);

      final defaultTrack = campaign.defaultTrack;
      if (defaultTrack == null) {
        _navigateToTaskRoute(context, campaign.id);
        return;
      }

      final track = await client.getTrackById(defaultTrack);
      final registrationStage = track.data["registration_stage"];

      if (registrationStage == null || !context.mounted) {
        _navigateToTaskRoute(context, campaign.id);
        return;
      }

      try {
        final task = await client.createTaskFromStageId(registrationStage);
        if (context.mounted) {
          _navigateToTaskDetail(context, campaign.id, task.id);
        }
      } catch (e) {
        print(e);
        _navigateToTaskRoute(context, campaign.id);
      }
    } catch (e) {
      print(e);
    }
  }

  void _navigateToTaskDetail(BuildContext context, int campaignId, int taskId) {
    context.goNamed(TaskDetailRoute.name, pathParameters: {
      'cid': "$campaignId",
      'tid': taskId.toString(),
    });
  }

  void _navigateToTaskRoute(BuildContext context, int campaignId) {
    context.goNamed(TaskRoute.name, pathParameters: {
      'cid': "$campaignId",
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<SelectableCampaignCubit, RemoteDataState<Campaign>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Campaign> && state.data.isNotEmpty) {
          return MultiSliver(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
                child: Text(
                  context.loc.join_other_courses,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: theme.isLight ? theme.neutral30 : theme.neutral90,
                  ),
                ),
              ),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (context, index) {
                    final item = state.data[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: CardWithTitle(
                        title: item.name,
                        titleColor: Colors.black,
                        backgroundColor: Color(0xFFDCE1FF),
                        body: SizedBox(
                          height: 20,
                          width: double.infinity,
                          child: Text(
                            item.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        bottom: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: theme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => redirectToCampaignDetail(context, item),
                            child: Text(context.loc.join),
                          ),
                        ),
                        size: const Size(340, 150),
                        imageUrl: item.logo,
                        flex: 1,
                        onTap: () => redirectToCampaignDetail(context, item),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                  itemCount: state.data.length,
                ),
              )
            ],
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
