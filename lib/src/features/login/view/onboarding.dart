import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../campaign/bloc/campaign_cubit.dart';

class OnBoarding extends StatefulWidget {
  final BoxConstraints? constraints;

  const OnBoarding({super.key, this.constraints});

  @override
  State<StatefulWidget> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool isHover = false;

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
      final campaign = await context.read<api.GigaTurnipApiClient>().getCampaignById(campaignId);
      final isJoined = campaign.isJoined;

      if (context.mounted && !isJoined) await context.read<api.GigaTurnipApiClient>().joinCampaign(campaignId);

      if (context.mounted) context.pushNamed(TaskRoute.name, pathParameters: {'cid': '$campaignId'});
    }

    return Container(
      padding: (context.isSmall) ? const EdgeInsets.all(24) : null,
      constraints: widget.constraints,
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
          FutureBuilder<List<Campaign>>(
            future: context.read<CampaignCubit>().fetchCampaigns(query: {'featured': true}),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              if (snapshot.hasData) {
                final featuredList = snapshot.data ?? [];
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20
                    ),
                    itemCount: featuredList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          redirect(context, featuredList[index].id);
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (details) => setState(() {
                            isHover = true;
                          }),
                          onExit: (details) => setState(() {
                            isHover = false;
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9EAFD),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Column(
                              children: [
                                // if (featuredList[index].featuredLogo != null)
                                //   Align(
                                //     alignment: Alignment.topCenter,
                                //     child: SizedBox(
                                //       height: 126,
                                //       child: Image.network(featuredList[index].logo),
                                //       // child: Image.network(featuredList[index].featuredLogo),
                                //     ),
                                //   ),
                                const SizedBox(height: 10),
                                Text(
                                    (featuredList[index].descriptor != null) ? featuredList[index].descriptor! : '',
                                    style: textStyle,
                                    textAlign: TextAlign.center
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
              }
              return const SizedBox.shrink();
            }
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
