import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';
import '../../router/routes/routes.dart';
import 'view/view.dart';

class RankTaskPage extends StatefulWidget {
  const RankTaskPage({Key? key}) : super(key: key);

  @override
  State<RankTaskPage> createState() => _RankTaskPageState();
}

class _RankTaskPageState extends State<RankTaskPage> {

  void redirect(BuildContext context, int? id) {
    if (id == null) {
      if (context.canPop()) {
        context.pop(true);
      } else {
        context.goNamed(
          RankRoute.name,
          pathParameters: {
            // 'cid': '${widget.campaignId}',
          },
        );
      }
    } else {
      context.goNamed(
          RankTaskDetailRoute.name,
          pathParameters: {
            ///rank task id
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        title: Text(
          'Журналист интервью-криейтинг',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: theme.neutral30,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () => redirect(context, null),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: theme.neutral30),
        ),
        backgroundColor: theme.background,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24, top: 20, right: 24, bottom: 34),
          // child: IndividualChainRankTaskView(),
          child: ArticleChainRankTaskView(),
          // child: AdditionalRankTaskView(),
        ),
      ),
    );
  }
}
