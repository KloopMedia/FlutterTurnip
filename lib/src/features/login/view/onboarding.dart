import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/error_box.dart';
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
      color: theme.primary,
    );

    Future<void> redirect(BuildContext context, int campaignId) async {
      final client = context.read<api.GigaTurnipApiClient>();
      final campaign = await client.getCampaignById(campaignId);
      final isJoined = campaign.isJoined;

      if (context.mounted && !isJoined) {
        await client.joinCampaign(campaignId);
      }

      if (!context.mounted) return;

      final defaultTrack = campaign.defaultTrack;
      if (defaultTrack != null) {
        final track = await client.getTrackById(defaultTrack);
        final registrationStage = track.data["registration_stage"];

        if (context.mounted && registrationStage != null) {
          try {
            final task = await client.createTaskFromStageId(registrationStage);
            if (context.mounted) {
              context.goNamed(TaskDetailRoute.name, pathParameters: {
                'cid': '$campaignId',
                'tid': task.id.toString(),
              });
            }
            return;
          } catch (e) {
            print(e);
          }
        }
      }

      if (context.mounted) context.goNamed(TaskRoute.name, pathParameters: {'cid': '$campaignId'});
    }

    return FutureBuilder<List<Campaign>>(
        future: context.read<CampaignCubit>().fetchCampaigns(query: {'featured': true}),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: NetworkErrorBox(
                snapshot.error as DioException,
                buttonText: 'Home',
                onPressed: () {
                  context.goNamed(CampaignRoute.name);
                },
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            final featuredList = snapshot.data ?? [];
            final itemCount = featuredList.length;

            if (featuredList.isEmpty) {
              context.goNamed(CampaignRoute.name);
            }

            return Container(
              padding: (context.isSmall) ? const EdgeInsets.all(24) : null,
              constraints: (kIsWeb && itemCount > 3)
                  ? const BoxConstraints(maxWidth: 680, maxHeight: 600)
                  : widget.constraints,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment:
                            (kIsWeb && itemCount < 3) ? Alignment.topCenter : Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Text(
                            context.loc.section_selection_title,
                            style: titleTextStyle,
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: (kIsWeb && itemCount < 3) ? Alignment.topCenter : Alignment.topLeft,
                      //   child: Text(
                      //     context.loc.section_selection,
                      //     style: subtitleTextStyle,
                      //   ),
                      // ),
                    ],
                  ),
                  if (itemCount == 1)
                    Center(
                      child: FeaturedCampaignCard(
                        item: featuredList.first,
                        width: 200,
                        height: 230,
                        onTap: () => redirect(context, featuredList.first.id),
                      ),
                    ),
                  if (!context.isSmall && itemCount > 1 && itemCount < 4)
                    Expanded(
                      child: Center(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = featuredList[index];
                            return FeaturedCampaignCard(
                              item: item,
                              width: 200,
                              verticalMargin: 20,
                              onTap: () => redirect(context, item.id),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 20);
                          },
                          itemCount: itemCount,
                        ),
                      ),
                    ),
                  if (!context.isSmall && itemCount > 3)
                    Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          shrinkWrap: false,
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 1),
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            final item = featuredList[index];
                            return FeaturedCampaignCard(
                              item: item,
                              onTap: () => redirect(context, item.id),
                            );
                          }),
                    ),
                  if (context.isSmall && itemCount == 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FeaturedCampaignCard(
                            item: featuredList[0],
                            onTap: () => redirect(context, featuredList[0].id),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: FeaturedCampaignCard(
                            item: featuredList[1],
                            onTap: () => redirect(context, featuredList[1].id),
                          ),
                        ),
                      ],
                    ),
                  if (context.isSmall && itemCount > 2)
                    Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          shrinkWrap: false,
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 0.75),
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            final item = featuredList[index];
                            return FeaturedCampaignCard(
                              item: item,
                              onTap: () => redirect(context, item.id),
                            );
                          }),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        context.goNamed(CampaignRoute.name, extra: true);
                      },
                      child: Text(context.loc.skip, style: textStyle),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}

class FeaturedCampaignCard extends StatefulWidget {
  final Campaign item;
  final double? width;
  final double? height;
  final double? verticalMargin;
  final Function() onTap;

  const FeaturedCampaignCard({
    super.key,
    required this.item,
    required this.onTap,
    this.verticalMargin,
    this.width,
    this.height,
  });

  @override
  State<FeaturedCampaignCard> createState() => _FeaturedCampaignCardState();
}

class _FeaturedCampaignCardState extends State<FeaturedCampaignCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black);

    return GestureDetector(
      onTap: () => widget.onTap(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (details) => setState(() {
          isHover = true;
        }),
        onExit: (details) => setState(() {
          isHover = false;
        }),
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.all(6),
          margin: (widget.verticalMargin == null)
              ? null
              : EdgeInsets.symmetric(vertical: widget.verticalMargin!),
          decoration: BoxDecoration(
              color: const Color(0xFFE9EAFD), borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.item.featuredImage != null && widget.item.featuredImage!.isNotEmpty)
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: Image.network(widget.item.featuredImage!),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                  (widget.item.shortDescription != null && widget.item.shortDescription!.isNotEmpty)
                      ? widget.item.shortDescription!
                      : '',
                  style: textStyle,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
