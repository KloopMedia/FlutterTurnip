import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import '../../../../features/campaign/bloc/category_bloc/category_cubit.dart';
import '../../../../features/campaign/bloc/country_bloc/country_cubit.dart';
import '../../../../features/campaign/bloc/language_bloc/language_cubit.dart';
import 'filter.dart';

class FilterPage extends StatelessWidget {
  final Function() onTap;
  const FilterPage({Key? key, required this.onTap}) : super(key: key);

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
      child: FilterView(onTap: () => onTap()),
    );
  }
}


class FilterView extends StatelessWidget {
  final Function() onTap;
  const FilterView({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final backgroundColor = theme.isLight ? Colors.white : theme.background;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;

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
          icon: Icon(Icons.arrow_back_ios, color: textColor,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            Filter<Country, CountryCubit>(title: context.loc.country),
            Filter<Category, CategoryCubit>(title: context.loc.category),
            Filter<Language, LanguageCubit>(title: context.loc.language),
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
                    onTap();
                    Navigator.pop(context);
                  },
                  child: Text(
                    context.loc.apply_filter,
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