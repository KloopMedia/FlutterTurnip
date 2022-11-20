import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String query = "";
  List filteredNames = [];
  List names = [];

  _SearchBarState() {
    textController.addListener(() {
      if (textController.text.isEmpty) {
        setState(() {
          query = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          query = textController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {



  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        // onSubmitted: (String _) {
        //   showResults(context);
        // },
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    ),
  );
}
}

class MySearchDelegate extends SearchDelegate {
  @override
  // ThemeData appBarTheme(BuildContext context) {
  //   assert(context != null);
  //   final ThemeData theme = Theme.of(context);
  //   assert(theme != null);
  //   return theme;
  // }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(
          Icons.arrow_back,
        ),
      );

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        )
      ];

  @override
  Widget buildResults(BuildContext context) => Container(
        child: const Text("Search"),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox();
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:gigaturnip/src/widgets/platform_search.dart';
//
//
//
//
// class MaterialSearchDelegate extends AbstractPlatformSearchDelegate {
//
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   Widget buildResults(BuildContext context) {
//     return Container(child: const Text("Search"),);
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return SizedBox();
//   }
//
//
// }
