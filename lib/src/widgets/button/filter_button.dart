import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/campaign/bloc/campaign_cubit.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

class FilterButton extends StatelessWidget {
  final void Function()? onPressed;

  const FilterButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final formFactor = context.formFactor;

    if (formFactor == FormFactor.small) {
      return IconButton(
        onPressed: () {
          context.goNamed(
            FilterRoute.name,
          );
        },
        icon: const Icon(Icons.tune_rounded));
    } else {
      return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17.5),
          side: BorderSide(color: theme.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        icon: const Icon(Icons.filter_list),
        label: const Text('Фильтр'),
      );
    }
  }
}

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
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
    final textStyle = theme.isLight ? theme.neutral30 : theme.neutral90;
    // final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    // final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        title: Text(
          'Фильтр',
          style: TextStyle(
            color: textStyle,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: textStyle,
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
            ///
            /*Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
              child: Text(
                'Страна',
                style: TextStyle(
                  color: theme.neutral40,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    context: context,
                    builder: (context) {
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
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_ios),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  Text(
                                    'Страна',
                                    style: TextStyle(
                                      color: textStyle,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                  itemCount: items.length,
                                  separatorBuilder: (context, _) {
                                    return const Divider();
                                  },
                                  itemBuilder: (context, index) {
                                    return StatefulBuilder(
                                      builder: (context, setSBState) {
                                        return CheckboxListTile(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          contentPadding: const EdgeInsets.all(0.0),
                                          value: filterData.contains(items[index]),
                                          title: Text(items[index]),
                                          onChanged: (value) {
                                            if (filterData.contains(items[index])) {
                                              filterData.remove(items[index]);
                                            } else {
                                              filterData.add(items[index]);
                                            }
                                            setSBState(() {
                                              setState(() {
                                                query['country'] = items[index];
                                              });
                                            });
                                          },
                                        );
                                      }
                                    );
                                  }
                              ),
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
                                  onPressed: () {},
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
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                minimumSize: const Size.fromHeight(54.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                side: BorderSide(
                  color: dropdownValue != null ? theme.primary : theme.neutral95
                ),
                backgroundColor: theme.isLight ? theme.neutral95 : theme.onSecondary,
                textStyle: TextStyle(
                  color: dropdownValue != null
                      ? dropdownValueColor
                      : hintTextColor,
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
                      color: dropdownValue != null
                        ? dropdownValueColor
                        : hintTextColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.primary),
                ],
              ),
            ),*/
            ///
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

class CountryFilter extends StatefulWidget {
  const CountryFilter({Key? key}) : super(key: key);

  @override
  State<CountryFilter> createState() => _CountryFilterState();
}

class _CountryFilterState extends State<CountryFilter> {
  String? dropdownValue;
  Map<String, dynamic> query = {};
  List<String> filterData = [];
  List<String> items = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textStyle = theme.isLight ? theme.neutral30 : theme.neutral90;
    final dropdownValueColor = theme.isLight ? theme.neutral40 : theme.neutral90;
    final hintTextColor = theme.isLight ? theme.neutral80 : theme.neutral50;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
          child: Text(
            'Страна',
            style: TextStyle(
              color: theme.neutral40,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                context: context,
                builder: (context) {
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
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios),
                                onPressed: () => Navigator.pop(context),
                              ),
                              Text(
                                'Страна',
                                style: TextStyle(
                                  color: textStyle,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                              itemCount: items.length,
                              separatorBuilder: (context, _) {
                                return const Divider();
                              },
                              itemBuilder: (context, index) {
                                return StatefulBuilder(
                                    builder: (context, setSBState) {
                                      return CheckboxListTile(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        contentPadding: const EdgeInsets.all(0.0),
                                        value: filterData.contains(items[index]),
                                        title: Text(items[index]),
                                        onChanged: (value) {
                                          if (filterData.contains(items[index])) {
                                            filterData.remove(items[index]);
                                          } else {
                                            filterData.add(items[index]);
                                          }
                                          setSBState(() {
                                            query['countries__name'] = items[index];
                                          });
                                        },
                                      );
                                    }
                                );
                              }
                          ),
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
                                setState(() {
                                  dropdownValue = query['countries__name'];
                                });
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
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            minimumSize: const Size.fromHeight(54.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            side: BorderSide(
                color: dropdownValue != null ? theme.primary : theme.neutral95
            ),
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
              Icon(
                  Icons.keyboard_arrow_down,
                  color: theme.primary),
            ],
          ),
        ),
      ],
    );
  }
}


class WebFilterField extends StatelessWidget {
  const WebFilterField({Key? key, this.dropdownValue}) : super(key: key);
  final String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Text(
            'Страна',
            style: TextStyle(
              color: theme.neutral40,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          style: TextStyle(
            color: theme.neutral40,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: 'Выберите',
            hintStyle: TextStyle(
              color: theme.neutral80,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.neutral95, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.primary, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            filled: true,
            fillColor: theme.neutral95,
            prefixIconConstraints: const BoxConstraints(minWidth: 20, maxHeight: 54),
          ),
          isExpanded: true,
          isDense: true,
          icon: Icon(Icons.keyboard_arrow_down, color: theme.primary),
          value: dropdownValue,//context.read<LocalizationBloc>().state.locale.languageCode.split('_').first,
          onChanged: (locale) {},
          items: const [
            DropdownMenuItem(
              value: 'ch',
              child: Text('Choose'),
            ),
            DropdownMenuItem(
              value: 'ky',
              child: Text('Кыргыз тили'),
            ),
            DropdownMenuItem(
              value: 'ru',
              child: Text('Русский'),
            ),
          ],
        ),
      ],
    );
  }
}
