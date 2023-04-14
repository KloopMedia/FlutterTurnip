import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/features/campaign/desktop/web_campaign_card/web_campaign_card.dart';
import 'package:gigaturnip/src/theme/shadows.dart';
import 'package:gigaturnip/src/theme/theme.dart';

import '../widgets/campaign_card/card_description.dart';

class WebCampaignListItem extends StatelessWidget {
  final String tag;
  final String title;
  final String? description;
  final String image;
  final void Function()? onTap;

  const WebCampaignListItem({
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
      margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
      decoration: BoxDecoration(
        boxShadow: Shadows.elevation3,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: WebCampaignCard(
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