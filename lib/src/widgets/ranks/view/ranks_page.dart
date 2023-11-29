import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/index.dart';

class RanksPage extends StatefulWidget {
  const RanksPage({Key? key}) : super(key: key);

  @override
  State<RanksPage> createState() => _RanksPageState();
}

class _RanksPageState extends State<RanksPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    // final image = (url != null
    //     ? NetworkImage(url!)
    //     : const AssetImage('assets/images/placeholder.png')) as ImageProvider;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Достижения',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: theme.neutral30,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: theme.neutral90),
        ),
        backgroundColor: theme.neutralVariant100,
      ),
      backgroundColor: theme.neutralVariant100,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              color: theme.background,
              boxShadow: Shadows.elevation3,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column( ///replace with CustomScrollView or ListView
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
                const SizedBox(height: 30),

                Container(
                  child: Stack(
                    alignment: Alignment.topCenter,
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
                                        child: Text(
                                          '200/200',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: theme.neutral100,
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

                      Positioned(
                        left: 5,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ///TODO: white border around image
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: const Image(image: AssetImage('assets/images/rank_icon_sample.png'), width: 32)),
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: const Image(image: AssetImage('assets/images/rank_icon_sample.png'), width: 32)),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -8,
                        right: -5,
                        child: Image.asset('assets/images/medal.png'),
                      )

                    ],
                  ),
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
    );
  }
}
