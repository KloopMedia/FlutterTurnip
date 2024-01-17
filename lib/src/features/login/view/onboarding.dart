import 'package:flutter/foundation.dart';
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
    final textStyle = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: theme.primary
    );

    Future<void> redirect (BuildContext context, int campaignId) async {
      final campaign = await context.read<api.GigaTurnipApiClient>().getCampaignById(campaignId);
      final isJoined = campaign.isJoined;

      if (context.mounted && !isJoined) await context.read<api.GigaTurnipApiClient>().joinCampaign(campaignId);

      if (context.mounted) context.goNamed(TaskRoute.name, pathParameters: {'cid': '$campaignId'});
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
                final itemCount = featuredList.length;

                if (itemCount == 1) {
                  final item = featuredList.first;

                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        redirect(context, item.id);
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (details) => setState(() {
                          isHover = true;
                        }),
                        onExit: (details) => setState(() {
                          isHover = false;
                        }),
                        child: FeaturedCampaignCard(item: item, itemCount: itemCount),
                      ),
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: (!kIsWeb) ? 0 : 30),
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: (!kIsWeb) ? 20 : 30,
                          mainAxisSpacing: (!kIsWeb) ? 20 : 30,
                          childAspectRatio: (!kIsWeb) ? 0.75 : 1
                      ),
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        final item = featuredList[index];
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
                            child: FeaturedCampaignCard(item: item, itemCount: itemCount),
                          ),
                        );
                      }
                  ),
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
                style: textStyle
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedCampaignCard extends StatelessWidget {
  final Campaign item;
  final int itemCount;

  const FeaturedCampaignCard({
    super.key,
    required this.item,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black
    );

    return Container(
      width: (itemCount == 1) ? 220 : null,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFFE9EAFD),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (item.featuredImage != null && item.featuredImage!.isNotEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 100,
                child: Image.network(item.featuredImage!),
              ),
            ),
          const SizedBox(height: 20),
          Text(
              (item.shortDescription != null && item.shortDescription!.isNotEmpty)
                  ? item.shortDescription! : '',
              style: textStyle,
              textAlign: TextAlign.center
          ),
        ],
      ),
    );
  }
}
