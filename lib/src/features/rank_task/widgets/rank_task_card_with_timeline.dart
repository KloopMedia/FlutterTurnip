import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import 'custom_text_button.dart';

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
                  // Text(
                  //   '${context.loc.task_status_submitted} 11 Мая 12:30',
                  //  // context.loc.awaiting_review,
                  //  // context.loc.in_progress,
                  //  // context.loc.in_review,
                  //   style: const TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //       color: Color(0xFFB9B9B9)
                  //   ),
                  // ),

                  ///Начато
                  // Row(
                  //   children: [
                  //     Text(
                  //         '${context.loc.started}: ',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 14,
                  //             color: theme.neutral60
                  //         )
                  //     ),
                  //     Text(
                  //         '0',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 16,
                  //             color: theme.primary
                  //         )
                  //     ),
                  //     const SizedBox(width: 8),
                  //     Text(
                  //         '${context.loc.task_status_submitted}: ',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 14,
                  //             color: theme.neutral60
                  //         )
                  //     ),
                  //     Text(
                  //         '0',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 16,
                  //             color: theme.primary
                  //         )
                  //     ),
                  //   ],
                  // ),

                  ///Выполнено
                  Text(
                      context.loc.task_status_submitted,
                      // context.loc.pending,
                      // context.loc.not_completed,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: theme.tertiary
                      )
                  ),

                  ///Выполнить/ещё  button
                  CustomTextButton(title: context.loc.execute),
                  if (!isLastRow)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Divider(height: 1, color: theme.neutral90),
                    ),
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