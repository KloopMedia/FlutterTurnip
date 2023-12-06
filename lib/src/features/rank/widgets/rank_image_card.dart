import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../router/routes/routes.dart';
import 'widgets.dart';

class RankImageCard extends StatelessWidget {
  const RankImageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          child: const RankImage(),
          onTap: () => context.goNamed(RankTaskRoute.name)
        ),
        const Positioned(
          top: 1,
          left: 5,
          child: RequiredRank(),
        ),
        Positioned(
          top: -8,
          right: -5,
          child: Image.asset('assets/images/medal.png'),
        )
      ],
    );
  }
}
