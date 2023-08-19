import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FieldFilter extends StatefulWidget {
  final int stageId;
  final Map<String, dynamic> data;
  final void Function(Map<String, dynamic> value) onChanged;

  const FieldFilter(
      {super.key, required this.stageId, required this.onChanged, required this.data});

  @override
  State<FieldFilter> createState() => _FieldFilterState();
}

class _FieldFilterState extends State<FieldFilter> {
  late Future<TaskStageDetail> _future;
  late Map<String, dynamic> filterValue = widget.data;

  @override
  void initState() {
    final api = context.read<GigaTurnipApiClient>();
    _future = api.getTaskStageById(widget.stageId, query: {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const _padding = EdgeInsets.symmetric(vertical: 10);
    return FutureBuilder<TaskStageDetail>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<TaskStageDetail> response) {
        final data = response.data;
        if (response.connectionState != ConnectionState.done) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (data == null) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }

          final _fields =
              (data.filterFieldsSchema ?? []).map((e) => FieldFilterModel.fromSchema(e)).toList();

          return MultiSliver(children: [
            SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                final field = _fields[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${context.loc.field} ${field.title}',
                      style: const TextStyle(
                        color: Color(0xFF5C5F5F),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(height: 1),
                    const SizedBox(height: 10),
                    Padding(
                      padding: _padding,
                      child: Text(
                        context.loc.filter_value,
                        style: const TextStyle(
                          color: Color(0xFF5C5F5F),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    FilterTextField(
                      hintText: context.loc.your_text,
                      type: field.type,
                      value: filterValue[field.name],
                      onChanged: (value) {
                        setState(() {
                          if (value == null || value == '') {
                            filterValue.remove(field.name);
                          } else {
                            filterValue[field.name] = value;
                          }
                        });
                        widget.onChanged(filterValue);
                      },
                    ),
                  ],
                );
              },
              itemCount: _fields.length,
            ),
          ]);

          // return const SliverToBoxAdapter(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Поле',
          //         style: TextStyle(
          //           color: Color(0xFF5C5F5F),
          //           fontSize: 20,
          //           fontFamily: 'Roboto',
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       SizedBox(height: 5),
          //       Divider(height: 1),
          //       SizedBox(height: 10),
          //       Padding(
          //         padding: _padding,
          //         child: Text(
          //           'Название поля',
          //           style: TextStyle(
          //             color: Color(0xFF5C5F5F),
          //             fontSize: 16,
          //             fontFamily: 'Roboto',
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //       FilterTextField(hintText: 'Напишите название'),
          //       SizedBox(height: 20),
          //       Padding(
          //         padding: _padding,
          //         child: Text(
          //           'Тип поля',
          //           style: TextStyle(
          //             color: Color(0xFF5C5F5F),
          //             fontSize: 16,
          //             fontFamily: 'Roboto',
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //       FilterTextField(hintText: 'Выберите'),
          //       SizedBox(height: 20),
          //       Text(
          //         'Условия',
          //         style: TextStyle(
          //           color: Color(0xFF5C5F5F),
          //           fontSize: 20,
          //           fontFamily: 'Roboto',
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       SizedBox(height: 10),
          //       Padding(
          //         padding: _padding,
          //         child: Text(
          //           'Значение',
          //           style: TextStyle(
          //             color: Color(0xFF5C5F5F),
          //             fontSize: 16,
          //             fontFamily: 'Roboto',
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //       FilterTextField(hintText: 'Ваш текст'),
          //     ],
          //   ),
          // );

          // return MultiSliver(children: [
          //   SliverList.builder(
          //     itemBuilder: (BuildContext context, int index) {
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Поле ${index + 1}',
          //             style: const TextStyle(
          //               color: Color(0xFF5C5F5F),
          //               fontSize: 20,
          //               fontFamily: 'Roboto',
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //           const SizedBox(height: 5),
          //           const Divider(height: 1),
          //           const SizedBox(height: 10),
          //           Padding(
          //             padding: _padding,
          //             child: Text(
          //               'Название поля ${index + 1}',
          //               style: const TextStyle(
          //                 color: Color(0xFF5C5F5F),
          //                 fontSize: 16,
          //                 fontFamily: 'Roboto',
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           ),
          //           const FilterTextField(hintText: 'Напишите название'),
          //           const SizedBox(height: 20),
          //           Padding(
          //             padding: _padding,
          //             child: Text(
          //               'Тип поля ${index + 1}',
          //               style: const TextStyle(
          //                 color: Color(0xFF5C5F5F),
          //                 fontSize: 16,
          //                 fontFamily: 'Roboto',
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           ),
          //           const FilterTextField(hintText: 'Выберите'),
          //           const SizedBox(height: 20),
          //           const Text(
          //             'Условия',
          //             style: TextStyle(
          //               color: Color(0xFF5C5F5F),
          //               fontSize: 20,
          //               fontFamily: 'Roboto',
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //           const SizedBox(height: 10),
          //           const Padding(
          //             padding: _padding,
          //             child: Text(
          //               'Значение',
          //               style: TextStyle(
          //                 color: Color(0xFF5C5F5F),
          //                 fontSize: 16,
          //                 fontFamily: 'Roboto',
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           ),
          //           const FilterTextField(hintText: 'Ваш текст'),
          //           // const SizedBox(height: 10),
          //           // Row(
          //           //   mainAxisSize: MainAxisSize.min,
          //           //   mainAxisAlignment: MainAxisAlignment.center,
          //           //   crossAxisAlignment: CrossAxisAlignment.center,
          //           //   children: [
          //           //     TextButton(
          //           //       onPressed: () {},
          //           //       child: const Text(
          //           //         'Добавить условие',
          //           //         style: TextStyle(
          //           //           color: Color(0xFF5E80FA),
          //           //           fontSize: 14,
          //           //           fontFamily: 'Roboto',
          //           //           fontWeight: FontWeight.w500,
          //           //         ),
          //           //       ),
          //           //     ),
          //           //   ],
          //           // ),
          //           // const SizedBox(height: 30),
          //         ],
          //       );
          //     },
          //     itemCount: _fields.length,
          //   ),
          //   // Row(
          //   //   mainAxisSize: MainAxisSize.min,
          //   //   mainAxisAlignment: MainAxisAlignment.center,
          //   //   crossAxisAlignment: CrossAxisAlignment.center,
          //   //   children: [
          //   //     TextButton(
          //   //       onPressed: () {
          //   //         setState(() {
          //   //           _fields.add(const FieldFilterModel(name: '', type: '', value: ''));
          //   //         });
          //   //       },
          //   //       child: const Text(
          //   //         'Добавить поле',
          //   //         style: TextStyle(
          //   //           color: Color(0xFF5E80FA),
          //   //           fontSize: 14,
          //   //           fontFamily: 'Roboto',
          //   //           fontWeight: FontWeight.w500,
          //   //         ),
          //   //       ),
          //   //     ),
          //   //   ],
          //   // )
          // ]);
        }
      },
    );
  }
}

class FieldFilterModel {
  final String name;
  final String type;
  final String condition;
  final int stageId;
  final String title;

  const FieldFilterModel({
    required this.name,
    required this.type,
    required this.condition,
    required this.stageId,
    required this.title,
  });

  factory FieldFilterModel.fromSchema(Map<String, dynamic> json) {
    return FieldFilterModel(
      name: json['field_name'],
      type: json['type'],
      condition: json['condition'],
      stageId: json['stage_id'],
      title: json['title'],
    );
  }
}

class FilterTextField extends StatelessWidget {
  final String hintText;
  final String type;
  final dynamic value;
  final void Function(dynamic value) onChanged;

  const FilterTextField(
      {super.key, required this.hintText, required this.onChanged, required this.type, this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final _isNum = type == "integer" || type == "double";
    final inputType = _isNum ? TextInputType.number : null;
    final inputFormatters = _isNum ? [FilteringTextInputFormatter.digitsOnly] : null;

    return Container(
      height: 54,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: theme.neutral95,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: TextFormField(
        initialValue: value?.toString(),
        onChanged: (value) {
          if (_isNum) {
            final parsed = num.tryParse(value);
            onChanged(parsed);
          } else {
            onChanged(value);
          }
        },
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 15),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: theme.neutral80,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
