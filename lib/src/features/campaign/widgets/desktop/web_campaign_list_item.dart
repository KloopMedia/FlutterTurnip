import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'web_campaign_card/web_campaign_card.dart';
import 'web_campaign_card/web_campaign_description.dart';

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

class WebCampaignListItem extends StatelessWidget {
  final String tag;
  final String title;
  final String? description;
  final void Function()? onTap;

  const WebCampaignListItem({
    Key? key,
    required this.tag,
    required this.title,
    this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.h),
      decoration: BoxDecoration(
        boxShadow: _shadows,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: WebCampaignCard(
          tag: tag,
          title: title,
          body: WebCardDescription(description),
          imageUrl:
          'https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1',
        ),
      ),
    );
  }
}