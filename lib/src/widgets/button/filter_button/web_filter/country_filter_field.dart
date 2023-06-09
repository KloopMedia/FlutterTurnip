import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../../bloc/bloc.dart';
import '../../../../features/campaign/bloc/country_bloc/country_cubit.dart';

class CountryFilterField extends StatefulWidget {
  const CountryFilterField({Key? key}) : super(key: key);

  @override
  State<CountryFilterField> createState() => _CountryFilterFieldState();
}

class _CountryFilterFieldState extends State<CountryFilterField> {
  String? dropdownValue;
  final List<String?> selectedItemList = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;
    final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;
    if (dropdownValue != null) selectedItemList.add(dropdownValue);

    return BlocBuilder<CountryCubit, RemoteDataState<Country>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Country> && state.data.isNotEmpty) {
          final data = state.data;
          return SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Text(
                    'Страна',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                DropdownButtonFormField<String>(
                  style: TextStyle(
                    color: dropdownValueColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Выберите',
                    hintStyle: TextStyle(
                      color: hintTextColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.neutral95),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.primary),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: theme.isLight ? theme.neutral95 : theme.onSecondary,
                    prefixIconConstraints: const BoxConstraints(minWidth: 20, maxHeight: 48),
                  ),
                  isExpanded: true,
                  isDense: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: theme.primary),
                  value: dropdownValue,
                  onChanged: (value) {},
                  selectedItemBuilder: (context) {
                    return data.map((item) => Text(item.name)).toList();
                  },
                  items: data
                      .map((item) => DropdownMenuItem<String>(
                        value: item.name,
                       /* child: CheckboxField(
                          name: item.name,
                          selectedItemList: selectedItemList,
                          onChanged: (value) {
                            setState(() {
                              selectedItemList.add(value);
                              dropdownValue = value;
                              Navigator.pop(context);
                            });
                          },
                        )*/
                        child: StatefulBuilder(
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
                                    setState(() {
                                      dropdownValue = item.name;
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    setSBState((){
                                      if (selectedItemList.contains(item.name)) {
                                        selectedItemList.clear();
                                      }
                                    });
                                    setState(() {
                                      dropdownValue = null;
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            }
                        )
                      ))
                      .toList(),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      }
    );
  }
}

class CheckboxFilterField extends StatelessWidget {
  final String name;
  final Function(String? value) onChanged;
  final List<String?> selectedItemList;

  const CheckboxFilterField({
    Key? key,
    required this.onChanged,
    required this.name,
    required this.selectedItemList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setSBState) {
          return CheckboxListTile(
            contentPadding: const EdgeInsets.all(0.0),
            value: selectedItemList.contains(name),
            title: Text(name),
            onChanged: (value) {
              if (value!) {
                setSBState((){
                  if (!selectedItemList.contains(name)) {
                    selectedItemList.add(name);
                  }
                });
                onChanged(name);
                Navigator.pop(context);
              } else {
                setSBState((){
                  if (selectedItemList.contains(name)) {
                    selectedItemList.clear();
                  }
                });
                onChanged(null);
                Navigator.pop(context);
              }
            },
          );
        }
        );
  }
}
