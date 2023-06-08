import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import '../../../../features/campaign/bloc/category_bloc/category_cubit.dart';
import '../../../../features/campaign/bloc/country_bloc/country_cubit.dart';
import '../../../../features/campaign/bloc/language_bloc/language_cubit.dart';
import '../filters/country_filter.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      child: const FilterView(),
    );
  }
}


class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String? dropdownValue;
  Map<String, dynamic> query = {};
  List<String> filterData = [];
  List<String> items = ['A', 'B', 'C', 'D'];

  void redirect() {
    if (context.canPop()) {
      context.pop(true);
    } else {
      context.goNamed(CampaignRoute.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final backgroundColor = theme.isLight ? Colors.white : theme.background;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;
    // final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    // final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        title: Text(
          'Фильтр',
          style: TextStyle(
            color: textColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: textColor,
          ),
          onPressed: () {
            redirect();
          },
        ),
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            const CountryFilter(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: SizedBox(
                width: double.infinity,
                height: 52.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onPressed: () {
                    context.read<SelectableCampaignCubit>().refetchWithFilter(query);
                    context.read<UserCampaignCubit>().refetchWithFilter(query);
                  },
                  child: Text(
                    'Применить фильтр',
                    style: TextStyle(
                      color: theme.isLight ? theme.onPrimary : theme.neutral0,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}