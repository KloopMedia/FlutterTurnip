import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'chain_lines.dart';
import 'chain_sides.dart';

class TaskStageChain extends StatelessWidget {
  final String title;
  final String? status;
  final int lessonNum;
  final bool even;
  final bool isFirstTaskNotOpen;
  final Color lineColor;
  final void Function() onTap;

  const TaskStageChain({
    Key? key,
    required this.title,
    required this.status,
    required this.lessonNum,
    required this.even,
    this.isFirstTaskNotOpen = false,
    required this.lineColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titleTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: theme.isLight
          ? (status == 'Неотправлено') ? theme.neutral90 : theme.neutral40
          : (status == 'Неотправлено') ? theme.neutralVariant40 : theme.neutral70,
          // ? (status == 'Неотправлено' && !isFirstTaskNotOpen) ? theme.neutral90 : theme.neutral40
          // : (status == 'Неотправлено' && !isFirstTaskNotOpen) ? theme.neutralVariant40 : theme.neutral70,
    );

    return SizedBox(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ChainSide(color: lineColor, even: even),
          SizedBox(
            height: 90.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  if (!even) LessonIcon(
                    lessonNum: lessonNum,
                    status: status,
                    isFirstTaskNotOpen: isFirstTaskNotOpen,
                  ),
                  Expanded(
                      child: TextButton(
                        onPressed: (status == 'Неотправлено') ? null : onTap,
                        // onPressed: (status == 'Неотправлено' && !isFirstTaskNotOpen) ? null : onTap,
                        child: Text(
                          title,
                          style: titleTextStyle,
                          textAlign: even ? TextAlign.end : TextAlign.start,
                        ),
                      ),
                    ),
                  if (even) LessonIcon(
                    lessonNum: lessonNum,
                    status: status,
                    isFirstTaskNotOpen: isFirstTaskNotOpen,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LessonIcon extends StatelessWidget {
  final int lessonNum;
  final String? status;
  final bool isFirstTaskNotOpen;

  const LessonIcon({
    Key? key,
    required this.lessonNum,
    required this.status,
    required this.isFirstTaskNotOpen,
  }) : super(key: key);

  // int getStatusIndexOfIconColor() {
  //   if (status == 'Отправлено') {
  //     return 0;
  //   } else if ((status == 'Возвращено') || (status == 'Неотправлено' && isFirstTaskNotOpen)){
  //     return 1;
  //   } else {
  //     return 2;
  //   }
  // }

  int getStatusIndexOfIconColor() {
    if (status == 'Отправлено') {
      return 0;
    } else if (status == 'Возвращено' || status == 'Активно'){
      return 1;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final lessonNumTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
      color: theme.isLight
          ? theme.onPrimary
          : (status == 'Неотправлено') ? theme.neutralVariant40 : theme.neutral100,
    );
    final index = getStatusIndexOfIconColor();
    final circleColorList = [
      [const Color(0xFF94A9F0), const Color(0xFFC0CEFF)],
      [const Color(0xFFBFAE0E), const Color(0xFFDFC902), const Color(0xFFDFC902)],
      theme.isLight ? [const Color(0xFFE1E3E3),const Color(0xFFE1E3E3)] : [const Color(0xFF5D5E67), const Color(0xFF5D5E67)]/*variant40*/
    ];
    final rombColorList = [
      const Color(0xFF748AD9),
      const Color(0xFFEAD620),
      theme.isLight ? const Color(0xFFEFF0F0) : const Color(0xFF767680)
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      width: 60.0,
      height: 60.0,
      decoration:
      BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: circleColorList[index],
          )
      ),
      child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: 0.8,
              child: Container(
                height: 37.0,
                width: 37.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  color: rombColorList[index],
                 ),
              ),
            ),
            Center(
              child: Text(
                '$lessonNum',
                style: lessonNumTextStyle,
              ),
            ),
          ]
      ),
    );
  }
}