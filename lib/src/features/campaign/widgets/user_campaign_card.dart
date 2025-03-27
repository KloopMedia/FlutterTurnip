import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/card/addons/card_chip.dart';

class UserCampaignCard extends StatelessWidget {
  final Campaign campaign;
  final double? height;
  final double? width;
  final int? titleMaxLines;

  const UserCampaignCard({
    super.key,
    required this.campaign,
    this.height,
    this.width,
    this.titleMaxLines,
  });

  void _redirectToTaskMenu(BuildContext context, Campaign campaign) async {
    final userId = context.read<AuthenticationRepository>().user.id;
    await context.read<SharedPreferences>().setString("${Constants.sharedPrefActiveCampaignKey}_$userId", campaign.id.toString());

    context.pushNamed(
      TaskRoute.name,
      pathParameters: {'cid': '${campaign.id}'},
      extra: campaign,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = campaign.featuredImage != null && campaign.featuredImage!.isNotEmpty;

    return Container(
      padding: EdgeInsets.all(10),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          // Shadow 1
          BoxShadow(
            color: Color(0x1A454545), // '#4545451A' in Flutter ARGB format
            offset: Offset(0, 1), // Horizontal and vertical offset
            blurRadius: 3, // Blur radius
            spreadRadius: 0, // Spread radius
          ),
          // Shadow 2
          BoxShadow(
            color: Color(0x1A454545), // '#4545451A' in Flutter ARGB format
            offset: Offset(0, 4), // Horizontal and vertical offset
            blurRadius: 8, // Blur radius
            spreadRadius: 3, // Spread radius
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _redirectToTaskMenu(context, campaign),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: titleMaxLines,
                      ),
                      Text(
                        campaign.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                if (hasImage)
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              campaign.featuredImage!,
                              height: 54,
                              width: 54,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            if (campaign.startDate != null || campaign.isCompleted)
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 8),
                      _CampaignStatusChip(campaign: campaign),
                    ],
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}

class _CampaignStatusChip extends StatelessWidget {
  final Campaign campaign;

  const _CampaignStatusChip({required this.campaign});

  @override
  Widget build(BuildContext context) {
    Widget? chip;

    if (campaign.startDate != null) {
      final startDateString = DateFormat.MMMMd(context.loc.localeName).format(campaign.startDate!);
      chip = CardChip(
        context.loc.course_start_at(startDateString),
        fontColor: Colors.white,
        backgroundColor: const Color(0xFF778CE0),
      );
    } else if (campaign.isCompleted) {
      chip = CardChip(
        context.loc.course_is_completed,
        fontColor: Colors.white,
        backgroundColor: const Color(0xFF74BF3B),
      );
    }

    if (chip == null) return const SizedBox.shrink();

    return Row(children: [chip]);
  }
}
