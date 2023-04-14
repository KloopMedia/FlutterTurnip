import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/theme.dart';

class WebCampaignCard extends StatelessWidget {
  final String tag;
  final String imageUrl;
  final String title;
  final double elevation;
  final Widget? body;
  final Color? color;
  final void Function()? onTap;

  const WebCampaignCard({
    Key? key,
    required this.tag,
    required this.imageUrl,
    required this.title,
    this.body,
    this.onTap,
    this.elevation = 0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: elevation,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CardChip(tag),
                      SizedBox(height: 10.h),
                      _CardTitle(title),
                    ],
                  ),
                ),
                if (imageUrl.isNotEmpty) _CardImage(imageUrl),
              ],
            ),
            SizedBox(height: 10.h),
            if (body != null) body!,
          ],
        ),
      ),
    );
  }
}

class _CardChip extends StatelessWidget {
  final String text;

  const _CardChip(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? theme.neutral40 : theme.neutral80;
    final backgroundColor = theme.isLight ? theme.neutral95 : theme.neutral20;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.h),
        child: Text(text, style: TextStyle(fontSize: 14.sp, color: fontColor)),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final String text;

  const _CardTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final String url;

  const _CardImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54.w,
      height: 54.h,
      child: Image.network(url),
    );
  }
}