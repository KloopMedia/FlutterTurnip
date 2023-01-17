import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/index.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool tap = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: textController,
          focusNode: focusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: (val) {
            print(val);
            // showResults(context);
            // transfer query --> textController
            context.read<TasksCubit>().filterTask(val);
          },
          decoration: InputDecoration(
              hintText: 'Search',
              // prefixIcon: tap ? SizedBox() : Icon(Icons.search),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                  onPressed: () {
                    context.read<TasksCubit>().filterTask(textController.text);
                  },
                  icon: const Icon(Icons.search),
              )),
        ),
      ),
    );
  }
}
