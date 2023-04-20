import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/theme.dart';

import 'base_card.dart';

class CardWithChipAndTitle extends StatelessWidget {
  final String tag;
  final String imageUrl;
  final String title;
  final double elevation;
  final Widget? body;
  final Widget? bottom;
  final Color? color;
  final Size? size;
  final int flex;
  final void Function()? onTap;

  const CardWithChipAndTitle({
    Key? key,
    required this.tag,
    required this.imageUrl,
    required this.title,
    this.body,
    this.bottom,
    this.onTap,
    this.elevation = 0,
    this.color,
    this.size,
    this.flex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titleStyle = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: theme.primary,
      overflow: TextOverflow.ellipsis,

    );
    return BaseCard(
      size: size,
      flex: flex,
      onTap: onTap,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardChip(tag),
                    const SizedBox(height: 10),
                    Text(title, maxLines: 2, style: titleStyle),
                  ],
                ),
              ),
              if (imageUrl.isNotEmpty)
                SizedBox(width: 54, height: 54, child: Image.network(imageUrl)),
            ],
          ),
          if (flex != 0) const Spacer(),
          if (body != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: body!,
            ),
        ],
      ),
      bottom: bottom,
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
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Text(text, style: TextStyle(fontSize: 14.sp, color: fontColor)),
      ),
    );
  }
}
