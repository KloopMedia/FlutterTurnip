import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:go_router/go_router.dart';
import '../../router/routes/routes.dart';
import 'widgets/widgets.dart';
import '../../theme/index.dart';

class RankPage extends StatefulWidget {
  const RankPage({Key? key}) : super(key: key);

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {

  void redirect(BuildContext context, int? id) {
    if (id == null) {
      if (context.canPop()) {
        context.pop(true);
      } else {
        context.goNamed(
          TaskRoute.name,
          pathParameters: {
            // 'cid': '${widget.campaignId}',
          },
        );
      }
    } else {
      context.goNamed(
        RankTaskRoute.name,
        pathParameters: {
          ///rank task id
        }
      );
    }
  }

  List<List<String>> getSortedList(List<String> items) {
    List<List<String>> listOfLists = [];

    for (int i = 0; i < items.length; i += 5) {
      int endIndex = i + 5;
      if (endIndex > items.length) {
        endIndex = items.length;
      }

      List<String> sublist = items.sublist(i, endIndex);

      if (sublist.length > 3) {
        listOfLists.add(sublist.sublist(0, 3));
        listOfLists.add(sublist.sublist(3));
      } else {
        listOfLists.add(sublist);
      }
    }
    return listOfLists;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    // final image = (url != null
    //     ? NetworkImage(url!)
    //     : const AssetImage('assets/images/placeholder.png')) as ImageProvider;

    List<String> items = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    List<List<String>> listOfLists = getSortedList(items);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.achievements,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: theme.neutral30,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () => redirect(context, null),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: theme.neutral90),
        ),
        backgroundColor: theme.neutralVariant100,
      ),
      backgroundColor: theme.neutralVariant100,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 60),
              padding: const EdgeInsets.symmetric(vertical: 24, /*horizontal: 24*/),
              decoration: BoxDecoration(
                color: theme.background,
                boxShadow: Shadows.elevation3,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'Name Surname',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: theme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage('assets/images/achievement_star.png'), width: 24),
                      const SizedBox(width: 5),
                      Text(
                        '568',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: theme.primary,
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: listOfLists.length,
                      itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: (index % 2 == 0) ? MainAxisAlignment.start : MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const RankImageCard(),
                              (listOfLists[index].length > 1) ? const RankImageCard() : const SizedBox.square(dimension: 130),
                              if (index % 2 == 0 && listOfLists[index].length == 3) const RankImageCard(),
                            ],
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              child: Image.asset('assets/images/user_achievement_ava.png'),
            ),
          ],
        ),
      ),
    );
  }
}
