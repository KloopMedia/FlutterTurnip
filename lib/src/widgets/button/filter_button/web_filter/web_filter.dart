import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../../../../bloc/bloc.dart';

class WebFilter<Data, Cubit extends RemoteDataCubit<Data>> extends StatelessWidget {
  final String title;
  final List<dynamic> queries;
  final Function(dynamic item) onTap;

  const WebFilter({
    Key? key,
    required this.title,
    required this.queries,
    required this.onTap,
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
          var fieldQueries = [];
          if (queries.isNotEmpty) {
            fieldQueries = queries.where(
                  (query) => data.any((item) => query == item),
            ).toList();
          }
        return SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    title,
                    style: textStyle,
                  ),
                ),
                DropdownFilterField(
                  fieldQueries: fieldQueries,
                  data: data,
                  onTap: (selectedItem) {
                    onTap(selectedItem);
                  },
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
  final List<dynamic> fieldQueries;
  final Function(dynamic item) onTap;

  const DropdownFilterField({
    Key? key,
    required this.data,
    required this.fieldQueries,
    required this.onTap,
  }) : super(key: key);

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

    if (widget.fieldQueries.isNotEmpty) {
      dropdownValue = widget.fieldQueries.first.name;
    } else {
      dropdownValue = null;
    }
    if (dropdownValue != null) {
      selectedItemList.clear();
      selectedItemList.add(dropdownValue);
    } else {
      selectedItemList.clear();
    }

    return DropdownButtonFormField<String>(
      style: TextStyle(
        color: dropdownValueColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: context.loc.select,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.isLight ? theme.neutral95 : theme.onSecondary),
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
      onChanged: (val) {},
      selectedItemBuilder: (context) {
        return widget.data.map((item) => Text(item.name)).toList();
      },
      borderRadius: BorderRadius.circular(15.0),
      items: widget.data
          .map((item) => DropdownMenuItem<String>(
          value: item.name,
          child: Column(
           children: [
             CheckboxField(
               name: item.name,
               selectedItemList: selectedItemList,
               onChanged: (value) {
                 setState(() {
                   dropdownValue = value;
                   selectedItemList.clear();
                   selectedItemList.add(value);
                   (value != null) ? widget.onTap(item) : widget.onTap(null);
                 });
               },
             ),
             (widget.data.indexOf(item) == widget.data.length - 1)
              ? const SizedBox.shrink()
              : const Divider(color: Colors.grey, height: 1),
           ],
         ),
      )).toList(),
    );
  }
}

class CheckboxField extends StatelessWidget {
  final String name;
  final Function(String? value) onChanged;
  final List<String?> selectedItemList;

  const CheckboxField({
    Key? key,
    required this.onChanged,
    required this.name,
    required this.selectedItemList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return StatefulBuilder(
      builder: (context, setSBState) {
        return CheckboxListTile(
          side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(width: 1.0, color: theme.neutralVariant70)),
          contentPadding: const EdgeInsets.all(0.0),
          value: selectedItemList.contains(name),
          title: Text(name),
          onChanged: (value) {
            if (value!) {
              setSBState((){
                selectedItemList.clear();
                selectedItemList.add(name);
              });
              onChanged(name);
              Navigator.pop(context);
            } else {
              setSBState((){
                selectedItemList.clear();
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
