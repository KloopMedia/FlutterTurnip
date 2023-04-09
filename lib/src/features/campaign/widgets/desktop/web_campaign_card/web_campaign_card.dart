import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebCampaignCard extends StatelessWidget {
  final String tag;
  final String imageUrl;
  final String title;
  final double? elevation;
  final Widget? body;
  final void Function()? onTap;

  const WebCampaignCard({
    Key? key,
    required this.tag,
    required this.imageUrl,
    required this.title,
    this.body,
    this.onTap,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CardChip(tag),
                      _CardTitle(title),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
                _CardImage(imageUrl),
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
    return Chip(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      backgroundColor: const Color(0xffF1F0FA),
      visualDensity: VisualDensity.compact,
      label: Text(text, style: TextStyle(fontSize: 14.sp)),
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
    return Container(
      width: 54.sp,
      height: 54.sp,
      decoration: BoxDecoration(
        image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(url)),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
