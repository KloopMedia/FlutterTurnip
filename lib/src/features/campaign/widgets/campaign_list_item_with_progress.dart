import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/theme/theme.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient, PaginationWrapper;
import 'package:gigaturnip_repository/gigaturnip_repository.dart' as repository;

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
  final repository.Campaign data;
  final void Function()? onTap;

  const CampaignListItemWithProgress({
    Key? key,
    required this.data,
    this.onTap,
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
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          color: theme.isLight ? theme.primaryContainer : theme.secondaryContainer,
          child: Column(
            children: [
              CampaignCard(
                tag: 'Placeholder',
                title: data.name,
                elevation: 0,
                color: theme.isLight ? Colors.white : theme.onSecondary,
                imageUrl: data.logo,
                body: FutureBuilder(
                  future: context.read<GigaTurnipApiClient>().getUserNotifications(query: {
                    'campaign': data.id,
                    'viewed': false,
                  }),
                  builder: (BuildContext context, AsyncSnapshot<PaginationWrapper> snapshot) {
                    if (snapshot.hasData && snapshot.data!.count > 0) {
                      return CardMessage('У вас ${snapshot.data!.count} непрочитанное сообщение');
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              // _CampaignProgress(padding: EdgeInsets.all(10.h)),
            ],
          ),
        ),
      ),
    );
  }
}

class _CampaignProgress extends StatelessWidget {
  final EdgeInsetsGeometry? _padding;

  const _CampaignProgress({Key? key, EdgeInsetsGeometry? padding})
      : _padding = padding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: _padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Осталось 4 задания до следующего уровня!',
            style: TextStyle(fontSize: 14.sp, color: theme.onSurfaceVariant),
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
          ),
        ],
      ),
    );
  }
}
