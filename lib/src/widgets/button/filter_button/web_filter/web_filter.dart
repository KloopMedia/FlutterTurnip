import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../../../../bloc/bloc.dart';

class WebFilter<Data, Cubit extends RemoteDataCubit<Data>> extends StatelessWidget {
  final String title;

  const WebFilter({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;
    final textStyle = TextStyle(
      color: textColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    );

    return BlocBuilder<Cubit, RemoteDataState<Data>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<Data> && state.data.isNotEmpty) {
          final data = state.data;
          return SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Text(
                    title,
                    style: textStyle,
                  ),
                ),
                DropdownFilterField(
                  data: data,
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

class DropdownFilterField extends StatefulWidget {
  final List<dynamic> data;

  const DropdownFilterField({Key? key, required this.data}) : super(key: key);

  @override
  State<DropdownFilterField> createState() => _DropdownFilterFieldState();
}

class _DropdownFilterFieldState extends State<DropdownFilterField> {
  String? dropdownValue;
  final List<String?> selectedItemList = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;
    if (dropdownValue != null) selectedItemList.add(dropdownValue);

    return DropdownButtonFormField<String>(
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
        return widget.data.map((item) => Text(item.name)).toList();
      },
      items: widget.data
          .map((item) => DropdownMenuItem<String>(
          value: item.name,
         child: CheckboxFilterField(
           name: item.name,
           selectedItemList: selectedItemList,
           onChanged: (value) {
             setState(() {
               dropdownValue = value;
               selectedItemList.clear();
               selectedItemList.add(value);
             });
           },
         ),
      )).toList(),
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
                  selectedItemList.clear();
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
