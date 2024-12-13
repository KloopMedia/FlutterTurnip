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
import 'package:intl/intl.dart';

import '../../../router/routes/routes.dart';
import '../../campaign/bloc/campaign_cubit.dart';

/// Shown after successful login, allows user to select featured campaigns or skip.
class OnBoarding extends StatefulWidget {
  final BoxConstraints? constraints;

  const OnBoarding({super.key, this.constraints});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Campaign>>(
      future: context.read<CampaignCubit>().fetchCampaigns(query: {'featured': true}),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorState(context, snapshot.error);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final featuredList = snapshot.data ?? [];
          if (featuredList.isEmpty) {
            context.goNamed(CampaignRoute.name);
            return const SizedBox.shrink();
          }
          return _buildContent(context, featuredList);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildErrorState(BuildContext context, Object? error) {
    return Center(
      child: NetworkErrorBox(
        error as DioException,
        buttonText: 'Home',
        onPressed: () => context.goNamed(CampaignRoute.name),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Campaign> featuredList) {
    final itemCount = featuredList.length;
    final theme = Theme.of(context).colorScheme;
    final fontColor = theme.isLight ? theme.neutral30 : theme.neutral90;

    final titleTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: fontColor,
    );

    final textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: theme.primary,
    );

    return Container(
      padding: context.isSmall ? const EdgeInsets.all(24) : null,
      constraints: (kIsWeb && itemCount > 3)
          ? const BoxConstraints(maxWidth: 680, maxHeight: 600)
          : widget.constraints,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeader(context, titleTextStyle, itemCount),
          _buildCampaignLayout(context, featuredList),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () => context.goNamed(CampaignRoute.name, extra: true),
              child: Text(context.loc.skip, style: textStyle),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TextStyle titleTextStyle, int itemCount) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Align(
        alignment: (kIsWeb && itemCount < 3) ? Alignment.topCenter : Alignment.topLeft,
        child: Text(
          context.loc.section_selection_title,
          style: titleTextStyle,
        ),
      ),
    );
  }

  Widget _buildCampaignLayout(BuildContext context, List<Campaign> featuredList) {
    final itemCount = featuredList.length;

    if (itemCount == 1) {
      return Center(
        child: FeaturedCampaignCard(
          item: featuredList.first,
          width: 200,
          height: 230,
          onTap: () => _redirect(context, featuredList.first.id),
        ),
      );
    }

    if (!context.isSmall) {
      if (itemCount > 1 && itemCount < 4) {
        return Expanded(child: _buildHorizontalList(context, featuredList));
      } else if (itemCount >= 4) {
        return Expanded(child: _buildGrid(context, featuredList, 3, 1));
      }
    }

    // Small screens
    if (context.isSmall && itemCount == 2) {
      return _buildTwoCardsRow(context, featuredList);
    } else if (context.isSmall && itemCount > 2) {
      return Expanded(child: _buildGrid(context, featuredList, 2, 0.75));
    }

    return const SizedBox.shrink();
  }

  Widget _buildHorizontalList(BuildContext context, List<Campaign> featuredList) {
    return Center(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: featuredList.length,
        itemBuilder: (context, index) {
          final item = featuredList[index];
          return FeaturedCampaignCard(
            item: item,
            width: 200,
            verticalMargin: 20,
            onTap: () => _redirect(context, item.id),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<Campaign> featuredList, int crossAxisCount, double aspectRatio) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 24),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: aspectRatio,
      ),
      itemCount: featuredList.length,
      itemBuilder: (context, index) {
        final item = featuredList[index];
        return FeaturedCampaignCard(
          item: item,
          onTap: () => _redirect(context, item.id),
        );
      },
    );
  }

  Widget _buildTwoCardsRow(BuildContext context, List<Campaign> featuredList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: FeaturedCampaignCard(
            item: featuredList[0],
            onTap: () => _redirect(context, featuredList[0].id),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FeaturedCampaignCard(
            item: featuredList[1],
            onTap: () => _redirect(context, featuredList[1].id),
          ),
        ),
      ],
    );
  }

  Future<void> _redirect(BuildContext context, int campaignId) async {
    final client = context.read<api.GigaTurnipApiClient>();
    final campaign = await client.getCampaignById(campaignId);

    if (!mounted) return;

    if (!campaign.isJoined) {
      await client.joinCampaign(campaignId);
      if (!mounted) return;
    }

    if (campaign.registrationStage != null) {
      try {
        final task = await client.createTaskFromStageId(campaign.registrationStage!);
        if (mounted) {
          context.goNamed(
            TaskDetailRoute.name,
            pathParameters: {'cid': '$campaignId', 'tid': task.id.toString()},
          );
        }
        return;
      } catch (e) {
        debugPrint('Error creating task from stage: $e');
      }
    }

    if (mounted) {
      context.goNamed(TaskRoute.name, pathParameters: {'cid': '$campaignId'});
    }
  }
}

class FeaturedCampaignCard extends StatefulWidget {
  final Campaign item;
  final double? width;
  final double? height;
  final double? verticalMargin;
  final VoidCallback onTap;

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
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF5E81FB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              _buildCampaignHeader(context, widget.item),
              _buildCardContent(widget.item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignHeader(BuildContext context, Campaign campaign) {
    String? headerText;
    if (campaign.startDate != null) {
      final formattedDate = DateFormat.MMMMd(context.loc.localeName).format(campaign.startDate!);
      headerText = context.loc.course_start_at(formattedDate);
    } else if (campaign.isCompleted) {
      headerText = context.loc.course_is_completed;
    }

    if (headerText == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        headerText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCardContent(Campaign item) {
    const textStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black);

    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(6),
      margin: widget.verticalMargin != null
          ? EdgeInsets.symmetric(vertical: widget.verticalMargin!)
          : null,
      decoration: BoxDecoration(
        color: const Color(0xFFE9EAFD),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (item.featuredImage != null && item.featuredImage!.isNotEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: Image.network(item.featuredImage!),
            ),
          const SizedBox(height: 20),
          Text(
            (item.shortDescription?.isNotEmpty ?? false) ? item.shortDescription! : '',
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}