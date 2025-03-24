import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

import 'types.dart';

class LessonIcon extends StatelessWidget {
  final int lessonNum;
  final ChainInfoStatus status;

  const LessonIcon({
    Key? key,
    required this.lessonNum,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final lessonNumTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.0,
      color: theme.isLight
        ? Colors.white
        : status == ChainInfoStatus.notStarted ? theme.neutralVariant40 : Colors.white,
    );

    final circleColorSchema = {
      ChainInfoStatus.complete: [
        const Color(0xFF94A9F0),
        const Color(0xFFC0CEFF),
      ],
      ChainInfoStatus.returned: [
        const Color(0xFFBFAE0E),
        const Color(0xFFDFC902),
        const Color(0xFFDFC902),
      ],
      ChainInfoStatus.active: [
        const Color(0xFFBFAE0E),
        const Color(0xFFDFC902),
        const Color(0xFFDFC902),
      ],
      ChainInfoStatus.notStarted: theme.isLight
          ? [const Color(0xFFE1E3E3), const Color(0xFFE1E3E3)]
          : [const Color(0xFF5D5E67), const Color(0xFF5D5E67)]
    };

    final rhombusColorSchema = {
      ChainInfoStatus.complete: const Color(0xFF748AD9),
      ChainInfoStatus.active: const Color(0xFFEAD620),
      ChainInfoStatus.returned: const Color(0xFFEAD620),
      ChainInfoStatus.notStarted: theme.isLight ? const Color(0xFFEFF0F0) : const Color(0xFF767680)
    };

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      width: 57.0,
      height: 57.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: circleColorSchema[status]!,
          )),
      child: Stack(alignment: Alignment.center, children: [
        Transform.rotate(
          angle: 0.8,
          child: Container(
            height: 35.0,
            width: 35.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              color: rhombusColorSchema[status],
            ),
          ),
        ),
        Center(
          child: Text(
            '$lessonNum',
            style: lessonNumTextStyle,
          ),
        ),
      ]),
    );
  }
}
