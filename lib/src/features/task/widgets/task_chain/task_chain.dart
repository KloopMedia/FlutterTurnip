import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'chain_lines.dart';
import 'chain_sides.dart';
import 'status_tag.dart';

class TaskChain extends StatelessWidget {
  final String title;
  final bool complete;
  final int lessonNum;
  final bool even;
  final bool start;
  final bool end;

  const TaskChain({
    Key? key,
    required this.title,
    required this.complete,
    required this.lessonNum,
    required this.even,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   alignment: AlignmentDirectional.center,
    //   children: [
    //     even ? rightSide : leftSide,
    //     Container(
    //       height: 90.0,
    //       // color: Colors.black26,
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 25.0),
    //         child: Row(
    //           children: [
    //             if(even)
    //               Expanded(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 crossAxisAlignment: CrossAxisAlignment.end,///
    //                 children: [
    //                   StatusTag(complete: complete),
    //                   Text(
    //                     title ?? 'Пройти тест по восприятию языка на слух',
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 16.sp,
    //                       color: Theme.of(context).colorScheme.neutral40, //dark = neutral70
    //                     ),
    //                     textAlign: TextAlign.end,///
    //                   )
    //                 ],
    //               ),
    //             ),
    //             /// circle lesson number
    //             // light/dark
    //             // yellow romb = EAD620
    //             // yellow box = DFC902, DFC902, BFAE0E
    //             Container(
    //               margin: const EdgeInsets.only(left: 10.0),
    //               width: 60.0,
    //               height: 60.0,
    //               decoration: const BoxDecoration(
    //                 shape: BoxShape.circle,
    //                 color: Colors.blueAccent,
    //                   gradient: LinearGradient(
    //                     begin: Alignment.bottomRight,
    //                     end: Alignment.topLeft,
    //                     colors: [
    //                       Colors.blueAccent,
    //                       Colors.lightBlueAccent
    //                       // light/dark
    //                       // Color[0xFFC0CEFF],
    //                       // Color[0xFF94A9F0],
    //                     ],
    //                   )
    //               ),
    //               child: Stack(
    //                 alignment: Alignment.center,
    //                 children: [
    //                   Transform.rotate(
    //                     angle: 0.8,
    //                     child: Container(
    //                       height: 37.0,
    //                       width: 37.0,
    //                       // color: const Color(0xFF748AD9),
    //                       decoration: const BoxDecoration(
    //                         borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //                         color: Color(0xFF748AD9),
    //                       ),
    //                     ),
    //                   ),
    //                   Center(
    //                     child: Text(
    //                       '$lessonNum',
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.w500,
    //                         fontSize: 20.sp,
    //                         color: Theme.of(context).colorScheme.onPrimary,
    //                       ),
    //                     ),
    //                   ),
    //                 ]
    //               ),
    //             ),
    //             if(!even)
    //               Expanded(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.start,///
    //                   children: [
    //                     StatusTag(complete: complete),
    //                     Text(
    //                       title ?? 'Пройти тест по восприятию языка на слух',
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.w500,
    //                         fontSize: 16.sp,
    //                         color: Theme.of(context).colorScheme.neutral40, //dark = neutral70
    //                         ///
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //           ],
    //         ),
    //       ),
    //     )
    //   ],
    // );
    final theme = Theme.of(context).colorScheme;
    final titleTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: theme.isLight ? theme.neutral40 : theme.neutral70,
    );

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        even ? rightSide : leftSide,
        Container(
          height: 90.0,
          // color: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                if (!even) LessonIcon(lessonNum: lessonNum),
                Expanded(
                    child: Text(
                      title,
                      style: titleTextStyle,
                      textAlign: even ? TextAlign.end : TextAlign.start,
                    ),
                  ),
                if (even) LessonIcon(lessonNum: lessonNum),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LessonIcon extends StatelessWidget {
  final int lessonNum;

  const LessonIcon({Key? key, required this.lessonNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // light/dark
    // yellow romb = EAD620
    // yellow box = DFC902, DFC902, BFAE0E

    final theme = Theme.of(context).colorScheme;
    final lessonNumTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
      color: theme.onPrimary,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      width: 60.0,
      height: 60.0,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent,
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Colors.blueAccent,
              Colors.lightBlueAccent
              // light/dark
              // Color[0xFFC0CEFF],
              // Color[0xFF94A9F0],
            ],
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Color(0xFF748AD9),// light/dark
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

// Widget startFlag = const Icon(
//   Icons.flag,
//   color: Color(0xFFDFC902),
//   size: 50.0,
// );
//
// Widget endStar = Stack(
//   alignment: Alignment.centerRight,
//   children: [
//     Row(
//       // crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(width: 40.0),
//         straightLine,
//         const SizedBox(width: 40.0),
//       ],
//     ),
//     const Icon(
//       Icons.star,
//       color: Color(0xFFE1E3E3),
//       size: 50.0,
//     ),
//   ],
// );

Widget rightSide = Row(
  mainAxisAlignment: MainAxisAlignment.end,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // const StraightLineWithPadding(rightPadding: false),
    const SizedBox(width: 40.0),
    straightLine,
    Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: CustomPaint(
        size: const Size(40, 120),
        painter: CurveRightLine(),
      ),
    ),
  ],
);

Widget leftSide =  Row(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: CustomPaint(
        size: const Size(40, 120),
        painter: CurveLeftLine(),
      ),
    ),
    // const StraightLineWithPadding(rightPadding: true),
    straightLine,
    const SizedBox(width: 40.0),
  ],
);

