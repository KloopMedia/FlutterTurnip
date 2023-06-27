import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/button/filter_button/mobile_filter/bottom_sheet.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import '../../../../features/campaign/bloc/category_bloc/category_cubit.dart';
import '../../../../features/campaign/bloc/country_bloc/country_cubit.dart';
import '../../../../features/campaign/bloc/language_bloc/language_cubit.dart';
import '../../../../bloc/bloc.dart';

class FilterPage extends StatelessWidget {
  final Function(dynamic item) onTap;
  final List<dynamic> queries;
  const FilterPage({Key? key, required this.onTap, required this.queries}) : super(key: key);

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
      child: FilterView(queries: queries, onTap: (selectedItems) => onTap(selectedItems)),
    );
  }
}


class FilterView extends StatelessWidget {
  final Function(dynamic item) onTap;
  final List<dynamic> queries;
  const FilterView({Key? key, required this.onTap, required this.queries/*queryMap*/}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List selectedItems = [];
    final theme = Theme.of(context).colorScheme;
    final backgroundColor = theme.isLight ? Colors.white : theme.background;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        title: Text(
          context.loc.filter,
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
            Filter<Country, CountryCubit>(
              queries: queries,
              title: context.loc.country,
              onTap: (selectedItem){
                if (selectedItem.isEmpty) {
                  selectedItems.removeWhere((element) => element is Country);
                } else {
                  selectedItems.addAll(selectedItem);
                }
              },
            ),
            Filter<Category, CategoryCubit>(
              queries: queries,
              title: context.loc.category,
              onTap: (selectedItem){
                if (selectedItem.isEmpty) {
                  selectedItems.removeWhere((element) => element is Category);
                } else {
                  selectedItems.addAll(selectedItem);
                }
              },
            ),
            Filter<Language, LanguageCubit>(
              queries: queries,
              title: context.loc.language,
              onTap: (selectedItem){
                if (selectedItem.isEmpty) {
                  selectedItems.removeWhere((element) => element is Language);
                } else {
                  selectedItems.addAll(selectedItem);
                }
              },
            ),
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
                    onTap(selectedItems);
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

class Filter<Data, Cubit extends RemoteDataCubit<Data>> extends StatelessWidget {
  final String title;
  final List<dynamic> queries;
  final Function(dynamic item) onTap;
  String? fieldQuery;

  Filter({
    Key? key,
    required this.title,
    required this.queries,
    required this.onTap,
  }) : super(key: key);

  void setFieldQuery(List<dynamic> data) {
      for (var query in queries) {
        if (data.contains(query)) {
          fieldQuery = query.name;
          break;
        } else {
          continue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    return BlocBuilder<Cubit, RemoteDataState<Data>>(
        builder: (context, state) {
          if (state is RemoteDataLoaded<Data> && state.data.isNotEmpty) {
            final data = state.data;
            setFieldQuery(data);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FilterField(
                  fieldQuery: fieldQuery,
                  queries: queries,
                  data: data,
                  title: title,
                  onTap: (selectedItem) {
                    final List<dynamic> list;
                    list = List.from(queries);
                    list.removeWhere((element) => element is Data);
                    if (selectedItem != null) list.add(selectedItem);
                    onTap(list);
                  },
                )
              ],
            );
          }
          return const SizedBox.shrink();
        }
    );
  }
}


class FilterField extends StatefulWidget {
  final List<dynamic> data;
  final List<dynamic> queries;
  final String title;
  final String? fieldQuery;
  final Function(dynamic item) onTap;

  const FilterField({
    Key? key,
    required this.data,
    required this.fieldQuery,
    required this.queries,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FilterField> createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  dynamic item;
  String? dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.fieldQuery;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;
    final backgroundColor = theme.isLight ? theme.neutral95 : theme.onSecondary;
    final textStyle = TextStyle(
      color: dropdownValue != null ? dropdownValueColor : hintTextColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    );
    if (item != null) {
      dropdownValue = item.name;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.transparent,
        elevation: 0.0,
        minimumSize: const Size.fromHeight(54.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        side: BorderSide(color: dropdownValue != null ? theme.primary : backgroundColor),
        backgroundColor: backgroundColor,
        textStyle: textStyle,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            dropdownValue ?? context.loc.select,
            style: textStyle,
          ),
          const Spacer(),
          Icon(Icons.keyboard_arrow_down, color: theme.primary),
        ],
      ),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
            backgroundColor: theme.background,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
            context: context,
            builder: (context) {
              return BottomSheetView(
                title: widget.title,
                data: widget.data,
                onTap: (selectedItem) {
                  if (selectedItem != null) {
                    setState(() {
                      dropdownValue = selectedItem.name;
                    });
                  } else {
                    setState(() {
                      dropdownValue = null;
                    });
                  }
                  widget.onTap(selectedItem);
                },
                value: dropdownValue,
                queries: widget.queries,
              );
            }
        );
      },
    );
  }
}