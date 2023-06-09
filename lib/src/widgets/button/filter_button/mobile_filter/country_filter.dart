import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../../bloc/bloc.dart';
import '../../../../features/campaign/bloc/country_bloc/country_cubit.dart';

class CountryFilter extends StatefulWidget {
  const CountryFilter({Key? key}) : super(key: key);

  @override
  State<CountryFilter> createState() => _CountryFilterState();
}

class _CountryFilterState extends State<CountryFilter> {
  String? dropdownValue;
  Map<String, dynamic> query = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;
    final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;

    return BlocBuilder<CountryCubit, RemoteDataState<Country>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Country> && state.data.isNotEmpty) {
          final data = state.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                child: Text(
                  'Страна',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  minimumSize: const Size.fromHeight(54.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  side: BorderSide(color: dropdownValue != null ? theme.primary : theme.neutral95),
                  backgroundColor: theme.isLight ? theme.neutral95 : theme.onSecondary,
                  textStyle: TextStyle(
                    color: dropdownValue != null ? dropdownValueColor : hintTextColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      dropdownValue ?? 'Выберите',
                      style: TextStyle(
                        color: dropdownValue != null ? dropdownValueColor : hintTextColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.keyboard_arrow_down, color: theme.primary),
                  ],
                ),
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      context: context,
                      builder: (context) {
                        return FilterBottomSheet(
                          data: data,
                          onTap: (value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                          value: dropdownValue,
                        );
                      }
                  );
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      }
    );
  }
}

class FilterBottomSheet extends StatelessWidget {
  final List<Country> data;
  final Function(String? value) onTap;
  final String? value;
  final List<String> selectedItemList = [];

  FilterBottomSheet({
    Key? key,
    required this.data,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;
    if (value != null) {
      selectedItemList.add(value!);
    }
    String? dropdownValue;

    goBack() {
      Navigator.pop(context);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      height: 500.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => goBack()),
                Text(
                  'Страна',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FilterValueList(
                data: data,
                onChanged: (value) {
                  dropdownValue = value;
                },
              selectedItemList: selectedItemList,
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
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
                  onTap(dropdownValue);
                  goBack();
                },
                child: Text(
                  'Применить',
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
    );
  }
}

class FilterValueList extends StatelessWidget {
  final List<Country> data;
  final Function(String? value) onChanged;
  final List<String> selectedItemList;

  const FilterValueList({
    Key? key,
    required this.data,
    required this.onChanged,
    required this.selectedItemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (context, index) {
          final item = data[index];
          return StatefulBuilder(
              builder: (context, setSBState) {
                return CheckboxListTile(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  contentPadding: const EdgeInsets.all(0.0),
                  value: selectedItemList.contains(item.name),
                  title: Text(item.name),
                  onChanged: (value) {
                    if (value!) {
                      setSBState((){
                        if (!selectedItemList.contains(item.name)) {
                          selectedItemList.clear();
                          selectedItemList.add(item.name);
                        }
                      });
                      onChanged(item.name);
                    } else {
                      setSBState((){
                        if (selectedItemList.contains(item.name)) {
                          selectedItemList.clear();
                        }
                      });
                      onChanged(null);
                    }
                  },
                );
              }
          );
        }
    );
  }
}

