import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../features/login/view/pickers.dart';

class SearchBarDialog extends StatefulWidget{
  final List data;
  final Function(List value) onSubmit;

  const SearchBarDialog({
    super.key,
    required this.data,
    required this.onSubmit,
  });

  @override
  State<StatefulWidget> createState()  => SearchBarDialogState();
}

class SearchBarDialogState extends State<SearchBarDialog> {
  final textController = TextEditingController();
  List country = [];
  String countryName = '';
  String searchText = '';
  bool found = true;
  List filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = widget.data;
    textController.addListener(() {
      if (textController.text.isEmpty) {
        setState(() {
          countryName = '';
          searchText = '';
          found = true;
          filteredItems = widget.data;
        });
      } else {
        setState(() {
          searchText = textController.text.trim();
        });
        searchFunc();
      }
    });
  }

  void searchFunc() {
    List tempList = [];
    if (searchText.isNotEmpty) {
      for (int i = 0; i < widget.data.length; i++) {
        if(widget.data[i].name.toLowerCase().contains(searchText.toLowerCase())) {
          tempList.add(widget.data[i]);
        }
      }
      setState(() {
        found = true;
        filteredItems = tempList;
      });
    }

    if (filteredItems.isEmpty) {
      setState(() {
        found = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      children: [
        SizedBox(
          width: 428,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.loc.indicate_country,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF444748),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                context.loc.indicate_your_country,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF5C5F5F),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                context.loc.country,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5C5F5F),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFEFF1F1),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset('assets/images/search.png', color: const Color(0xFFC4C7C7))
                      ),
                    ),

                    (found)
                      ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  country.add(filteredItems[index]);
                                  countryName = filteredItems[index].name;
                                });
                                textController.text = countryName;
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  filteredItems[index].name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF45464F)
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          );
                        })
                      : Container(
                        height: size.height * 0.2,
                        width: size.width,
                        alignment: Alignment.center,
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SignUpButton(
                onPressed: () {
                  if (country.isNotEmpty) {
                    widget.onSubmit(country);
                    Navigator.pop(context);
                  }
                },
                buttonText: context.loc.confirm,
                width: double.infinity,
                isActive: country.isNotEmpty,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DropdownDialog extends StatefulWidget {
  final List data;
  final Function(List value) onSubmit;

  const DropdownDialog({
    Key? key,
    required this.data,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<DropdownDialog> createState() => _DropdownDialogState();
}

class _DropdownDialogState extends State<DropdownDialog> {
  List country = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.loc.indicate_country,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF444748),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  context.loc.indicate_your_country,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF5C5F5F),
                  ),
                ),
                const SizedBox(height: 10),
                CountryPicker(
                  campaignCountry: (country.isNotEmpty) ? country.first.name : null,
                  countries: widget.data,
                  onTap: (value) {
                    setState(() {
                      country = value;
                    });
                  },
                ),
                const SizedBox(height: 40),
                SignUpButton(
                  width: double.infinity,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onSubmit(country);
                      Navigator.pop(context);
                    }
                  },
                  buttonText: context.loc.further,
                  isActive: country.isNotEmpty,
                )
              ],
            ),
          ),
        ),
      ],
    );;
  }
}



