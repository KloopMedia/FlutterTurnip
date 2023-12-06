import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class RankTaskCardWithTimeline extends StatelessWidget {
  const RankTaskCardWithTimeline({
    Key? key,
    required this.title,
    required this.isLastRow,
  }) : super(key: key);

  final String title;
  final bool isLastRow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 14,
                  height: 14,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: theme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.primary,//Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: theme.neutral40,
                    ),
                    softWrap: true,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 7),

                  ///Выполнено 11 Мая 12:30
                  // const Text(
                  //   'Выполнено 11 Мая 12:30', //Проверяется //Выполняется //Ожидает проверки
                  //   style: TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //       color: Color(0xFFB9B9B9)
                  //   ),
                  // ),

                  ///Начато
                  Row(
                    children: [
                      Text(
                          'Начато: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: theme.neutral60
                          )
                      ),
                      Text(
                          '0',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: theme.primary
                          )
                      ),
                      const SizedBox(width: 8),
                      Text(
                          'Закончено: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: theme.neutral60
                          )
                      ),
                      Text(
                          '0',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: theme.primary
                          )
                      ),
                    ],
                  ),

                  ///Выполнено
                  // Text(
                  //     'Выполнено', //'Ожидает выполнения' //'Невыполнено'
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 14,
                  //         color: theme.tertiary
                  //     )
                  // ),

                  ///Выполнить/ещё  button
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Выполнить',//'Выполнить ещё'
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: theme.primary
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: theme.primary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  Divider(height: 1, color: theme.neutral90),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
        if (!isLastRow)
          Positioned(
            top: 14,
            bottom: 0,
            left: 6.3,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                color: theme.primary,//neutral80
                shape: BoxShape.rectangle,
              ),
              child: const Text(''),
            ),
          ),
      ],
    );
  }
}