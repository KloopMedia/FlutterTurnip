import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'campaign_card/campaign_card.dart';
import 'campaign_card/card_message.dart';

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

class CampaignListItemWithProgress extends StatelessWidget {
  final String tag;
  final String title;
  final String? description;
  final String image =
      'https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1';
  final void Function()? onTap;

  const CampaignListItemWithProgress({
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
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Column(
            children: [
              CampaignCard(
                tag: tag,
                title: title,
                elevation: 0,
                body: const CardMessage('У вас 1 непрочитанное сообщение'),
                imageUrl:
                    'https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1',
              ),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Осталось 4 задания до следующего уровня!',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.looks_one, color: Color(0xffDFC902)),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                              child: LinearProgressIndicator(
                                value: Random().nextDouble(),
                                minHeight: 6.h,
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.looks_two, color: Color(0xffDFC902)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
