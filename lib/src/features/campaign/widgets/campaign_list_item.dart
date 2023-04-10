import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/theme.dart';

import 'campaign_card/campaign_card.dart';
import 'campaign_card/card_description.dart';

const _shadows = [
  BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 3,
    color: Color(0x1A454545),
  ),
  BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 8,
    spreadRadius: 3,
    color: Color(0x1A454545),
  ),
];

// const _shadowsHover = [
//   BoxShadow(
//     offset: Offset(0, 2),
//     blurRadius: 4,
//     color: Color(0x1A454545),
//   ),
//   BoxShadow(
//     offset: Offset(0, 6),
//     blurRadius: 10,
//     spreadRadius: 6,
//     color: Color(0x1A454545),
//   ),
// ];

class CampaignListItem extends StatelessWidget {
  final String tag;
  final String title;
  final String? description;
  final String image;
  final void Function()? onTap;

  const CampaignListItem({
    Key? key,
    required this.tag,
    required this.title,
    this.description,
    this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      decoration: BoxDecoration(
        boxShadow: _shadows,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: CampaignCard(
          tag: tag,
          title: title,
          color: theme.isLight ? Colors.white : theme.onSecondary,
          body: CardDescription(description),
          imageUrl: image,
        ),
      ),
    );
  }
}
