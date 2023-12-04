import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

class AdditionalRankTaskDetailView extends StatelessWidget {
  const AdditionalRankTaskDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Получение ранга',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: theme.neutral40
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Чтобы получить ранг “Журналист интервью-криейтинг” Вам необходимо получить следующие ранги:',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: theme.onSurfaceVariant
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 29),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 130,
              height: 138,
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
                    maxLines: 2,
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
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 130,
              height: 138,
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
                    maxLines: 2,
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
          ],
        )
      ],
    );
  }
}
