import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final void Function()? onTap;

  const CampaignListItem({
    Key? key,
    required this.tag,
    required this.title,
    this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          body: CardDescription(description),
          imageUrl:
              'https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1',
        ),
      ),
    );
  }
}
