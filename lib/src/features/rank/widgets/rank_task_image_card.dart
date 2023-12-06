import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../theme/index.dart';

class RankTaskImageCard extends StatelessWidget {
  const RankTaskImageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => context.goNamed(RankTaskRoute.name),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width / 3,//130
            height: 154,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      const Image(image: AssetImage('assets/images/rank_icon_sample.png')),
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Container(
                            width: 90,
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: const Text(
                              '200/200',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Журналист интервьюер',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: theme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
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
      ),
    );
  }
}

class RequiredRank extends StatelessWidget {
  const RequiredRank({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          margin: const EdgeInsets.only(left: 5),
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: Shadows.elevation3,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: const Image(image: AssetImage('assets/images/rank_icon_sample.png'))),
        ),
        Container(
            width: 32,
            margin: const EdgeInsets.only(left: 5),
            padding: const EdgeInsets.only(left: 6, top: 7, right: 6, bottom: 6),
            decoration: BoxDecoration(
                color: theme.primary,
                shape: BoxShape.circle,
                boxShadow: Shadows.elevation3,
                border: Border.all(color: Colors.white)
            ),
            child: const Text(
              '+4',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
        ),
      ],
    );
  }

}
