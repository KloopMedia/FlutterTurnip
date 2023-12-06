import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../rank/widgets/widgets.dart';

class AdditionalRankTaskView extends StatelessWidget {
  const AdditionalRankTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.loc.receive_rank,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: theme.neutral40
          ),
        ),
        const SizedBox(height: 10),
        Text(
          context.loc.receive_rank_description('"Журналист"'),
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: theme.onSurfaceVariant
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: const RankImage(),
              onTap: () => context.goNamed(RankTaskDetailRoute.name),
            ),
            InkWell(
              child: const RankImage(),
              onTap: () => context.goNamed(RankTaskDetailRoute.name),
            ),
          ],
        )
      ],
    );
  }
}
