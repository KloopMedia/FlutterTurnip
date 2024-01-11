import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';

class OnBoarding extends StatelessWidget {
  final BoxConstraints? constraints;

  const OnBoarding({super.key, this.constraints});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    final titleTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: fontColor,
    );
    final subtitleTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: fontColor,
    );
    const textStyle = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black
    );

    Future<void> redirect (BuildContext context, int campaignId) async {
      final campaign = await context.read<GigaTurnipApiClient>().getCampaignById(campaignId);
      final isJoined = campaign.isJoined;

      if (context.mounted && !isJoined) await context.read<GigaTurnipApiClient>().joinCampaign(campaignId);

      if (context.mounted) context.pushNamed(TaskRoute.name, pathParameters: {'cid': '$campaignId'});
    }

    return Container(
      padding: (context.isSmall) ? const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0) : null,
      constraints: constraints,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (context.isSmall)
                IconButton(
                  padding: const EdgeInsets.only(bottom: 30),
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                ),
              Text(
                context.loc.section_selection_title,
                style: titleTextStyle,
              ),
              Text(
                context.loc.section_selection,
                style: subtitleTextStyle,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    const campaignId = 7;
                    redirect(context, campaignId);
                  },
                  child: Container(
                    height: 217,
                    padding: const EdgeInsets.only(left:15, top: 14.5, right:15/*, bottom: 27.5*/),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EAFD),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        const Image(image: AssetImage('assets/images/english_image.png'), height: 126.5),
                        const SizedBox(height: 10),
                        Text(context.loc.english_section, style: textStyle, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    const campaignId = 42;
                    redirect(context, campaignId);
                  },
                  child: Container(
                    height: 217,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFDF0E9),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    padding: const EdgeInsets.only(left:15, top: 8.5, right: 15/*, bottom: 27.5*/),
                    child: Column(
                      children: [
                        const Image(image: AssetImage('assets/images/mobilography_image.png'), height: 126.5),
                        const SizedBox(height: 10),
                        Text(context.loc.mobilography_section, style: textStyle, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                context.go(CampaignRoute.name);
              },
              child: Text(
                context.loc.skip,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: theme.primary
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
