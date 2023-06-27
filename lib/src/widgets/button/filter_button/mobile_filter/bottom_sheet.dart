import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class BottomSheetView extends StatelessWidget {
  final List<dynamic> data;
  final Function(dynamic value) onTap;
  final String? value;
  final List<dynamic> queries;
  final String title;

  const BottomSheetView({
    Key? key,
    required this.data,
    required this.onTap,
    required this.value,
    required this.queries,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic dropdownValue;
    final theme = Theme.of(context).colorScheme;
    final textColor = theme.isLight ? theme.neutral30 : theme.neutral90;

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
                    fontFamily: 'Roboto',
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
                queries: queries,
                onChanged: (value) {
                  if (value != null) {
                    dropdownValue = value;
                  } else {
                    dropdownValue = null;
                  }
                },
                dropdownValue: value
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
  final List<dynamic> queries;
  final Function(dynamic value) onChanged;
  final String? dropdownValue;

  const CheckboxFields({
    Key? key,
    required this.data,
    required this.queries,
    required this.onChanged,
    required this.dropdownValue,
  }) : super(key: key);

  @override
  State<CheckboxFields> createState() => _CheckboxFieldsState();
}

class _CheckboxFieldsState extends State<CheckboxFields> {
  final List<dynamic> selectedItemList = [];

  @override
  void initState() {
    if (widget.dropdownValue != null) {
      selectedItemList.add(widget.dropdownValue);
    }
    if (widget.queries.isNotEmpty) {
      for (var query in widget.queries) {
        selectedItemList.add(query.name);
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ListView.separated(
        itemCount: widget.data.length,
        separatorBuilder: (context, _) => const Divider(color: Colors.grey, height: 1),
        itemBuilder: (context, index) {
          final item = widget.data[index];
          return StatefulBuilder(
              builder: (context, setSBState) {
                return CheckboxListTile(
                  side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(width: 1.0, color: theme.neutralVariant70)),
                  contentPadding: const EdgeInsets.all(0.0),
                  value: selectedItemList.contains(item.name),
                  title: Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: theme.isLight ? theme.neutral30 : theme.neutral90
                    )
                  ),
                  onChanged: (value) {
                    setSBState((){
                      if (value!) {
                        setState((){
                          selectedItemList.clear();
                          selectedItemList.add(item.name);
                        });
                        widget.onChanged(item);
                      } else {
                        setState((){
                          selectedItemList.clear();
                        });
                        widget.onChanged(null);
                      }
                    });

                  },
                );
             }
          );
       }
    );
  }
}

