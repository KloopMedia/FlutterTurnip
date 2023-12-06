import 'dart:ui';
import 'package:flutter/material.dart';

class RankImage extends StatelessWidget {
  const RankImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
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
    );
  }
}