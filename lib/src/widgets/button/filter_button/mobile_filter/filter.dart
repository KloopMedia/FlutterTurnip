import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../../../../bloc/bloc.dart';
import '../../../../features/campaign/bloc/campaign_cubit.dart';
import '../../../../features/campaign/bloc/filter_bloc/filter_bloc.dart';

class Filter<Data, Cubit extends RemoteDataCubit<Data>> extends StatelessWidget {
  final String title;

  const Filter({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    return BlocBuilder<Cubit, RemoteDataState<Data>>(
        builder: (context, state) {
          if (state is RemoteDataLoaded<Data> && state.data.isNotEmpty) {
            final data = state.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FilterField(
                  data: data,
                  title: title,
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
  final String title;

  const FilterField({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  State<FilterField> createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  String? dropdownValue;
  Map<String, dynamic> queryMap = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;
    final country = context.loc.country;
    final category = context.loc.category;

    return ElevatedButton(
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
            dropdownValue ?? context.loc.select,
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
            context: context,
            builder: (context) {
              return BottomSheet(
                title: widget.title,
                data: widget.data,
                onTap: (selectedItem) {
                  setState(() {
                    dropdownValue = selectedItem;
                  });
                  if (widget.title == country) {
                    queryMap['countries__name'] = selectedItem;
                  } else if (widget.title == category) {
                    queryMap['categories'] = selectedItem;
                  } else {
                    queryMap['language__code'] = selectedItem;
                  }
                  context.read<FilterBloc>().add(SelectFilterItem(queryMap));
                  context.read<SelectableCampaignCubit>().refetchWithFilter(
                      {'countries__name': 'Кыргызстан'});
                  context.read<UserCampaignCubit>().refetchWithFilter(
                      {'countries__name': 'Кыргызстан'});
                },
                value: dropdownValue,
              );
            }
        );
      },
    );
  }
}

class BottomSheet extends StatelessWidget {
  final List<dynamic> data;
  final Function(String? value) onTap;
  final String? value;
  final String title;
  final List<String?> selectedItemList = [];

  BottomSheet({
    Key? key,
    required this.data,
    required this.onTap,
    required this.value,
    required this.title,
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
                  title,
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
              child: CheckboxFields(
                data: data,
                onChanged: (value) {
                  dropdownValue = value;
                  selectedItemList.clear();
                  selectedItemList.add(value);
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
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  onTap(dropdownValue);
                  goBack();
                },
                child: Text(
                  context.loc.apply,
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

class CheckboxFields extends StatefulWidget {
  final List<dynamic> data;
  final Function(String? value) onChanged;
  final List<String?> selectedItemList;
  const CheckboxFields({
    Key? key,
    required this.data,
    required this.onChanged,
    required this.selectedItemList,
  }) : super(key: key);

  @override
  State<CheckboxFields> createState() => _CheckboxFieldsState();
}

class _CheckboxFieldsState extends State<CheckboxFields> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: widget.data.length,
        separatorBuilder: (context, _) => const Divider(color: Colors.grey),
        itemBuilder: (context, index) {
          final item = widget.data[index];
          return StatefulBuilder(
              builder: (context, setSBState) {
                return CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: widget.selectedItemList.contains(item.name),
                  title: Text(item.name),
                  onChanged: (value) {
                    if (value!) {
                      setState((){
                        widget.selectedItemList.clear();
                        widget.selectedItemList.add(item.name);
                      });
                      widget.onChanged(item.name);
                    } else {
                      setState((){
                        widget.selectedItemList.clear();
                      });
                      widget.onChanged(null);
                    }
                  },
                );
             }
          );
       }
    );
  }
}

