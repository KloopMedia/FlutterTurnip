import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/theme.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({Key? key}) : super(key: key);

  ///without SearchField
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Кампании',
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.neutral30,
            ),
          ),
        ),
        const _WebSearchIcon(),
        SizedBox(width: 10.h),
        const _WebFilterBar(),
      ],
    );
  }

/// with SearchField
// @override
// Widget build(BuildContext context) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Container(
//             margin: EdgeInsets.zero,
//             width: 680.h,
//             height: 52.h,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20.r),
//               boxShadow: const [
//                 BoxShadow(
//                   offset: Offset(0, 2),
//                   blurRadius: 6,
//                   spreadRadius: 2,
//                   color: Color(0x1A454545),
//                 ),
//                 BoxShadow(
//                   offset: Offset(0, 1),
//                   blurRadius: 2,
//                   color: Color(0x1A454545),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               children: const [
//                 _WebSearchIcon(),
//                 _WebSearchField(),
//                 _WebSearchButton(),
//               ],
//             ),
//           ),
//       const _WebFilterBar(),
//     ],
//   );
// }
}

class _WebSearchIcon extends StatelessWidget {
  const _WebSearchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.sp, 5.sp, 12.sp, 0.sp),
      child: IconButton(
        onPressed: () {
          print('Button pressed...');
        },
        icon: Icon(
            Icons.search,
            size: 7.w,
            color: Theme.of(context).colorScheme.neutral30,
        ),
      ),
    );
  }
}

class _WebSearchField extends StatelessWidget {
  const _WebSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.sp,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );

    return Expanded(
      child: TextFormField(
        autofocus: true,
        decoration: InputDecoration.collapsed(
          hintText: 'Кампании, ключевые слова',
          hintStyle: textStyle,
        ),
        style: textStyle,
      ),
    );
  }
}

class _WebSearchButton extends StatelessWidget {
  const _WebSearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 14.sp),
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
        ),
        onPressed: () {
          print('Button pressed ...');
        },
        child: Text(
          'Искать',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

class _WebFilterBar extends StatelessWidget {
  const _WebFilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          padding: EdgeInsets.symmetric(horizontal: 50.sp, vertical: 14.sp),
          backgroundColor: Colors.transparent,
          elevation: 0,
          side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        onPressed: () {
          print('Button pressed ...');
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 24.h,
                height: 24.h,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiary
                ),
                child: Center(
                  child: Text(
                      '1',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(context).colorScheme.onPrimary)
                  ),
                )
            ),
            SizedBox(width: 10.h),
            Text(
              'Фильтр',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}