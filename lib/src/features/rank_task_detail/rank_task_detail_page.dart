import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';
import '../../router/routes/routes.dart';
import 'view/view.dart';

class RankTaskDetailPage extends StatefulWidget {
  const RankTaskDetailPage({Key? key}) : super(key: key);

  @override
  State<RankTaskDetailPage> createState() => _RankTaskDetailPageState();
}

class _RankTaskDetailPageState extends State<RankTaskDetailPage> {

  void redirect(BuildContext context) {
    if (context.canPop()) {
      context.pop(true);
    } else {
      context.goNamed(
        RankTaskRoute.name,
        pathParameters: {
          // 'cid': '${widget.campaignId}',
        },
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
          'Название задания',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: theme.neutral30,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () => redirect(context),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: theme.neutral30),
        ),
        backgroundColor: theme.background,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24, top: 20, right: 24, bottom: 34),
          child: AdditionalRankTaskDetailView(),
          // child: ArticleChainRankTaskDetailView(),
          // child: IndividualChainRankTaskDetailView(),
        ),
      ),
    );
  }
}
