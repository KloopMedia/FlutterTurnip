import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:intl/intl.dart';

class FeaturedCampaignCard extends StatefulWidget {
  final Campaign item;
  final VoidCallback onTap;

  const FeaturedCampaignCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<FeaturedCampaignCard> createState() => _FeaturedCampaignCardState();
}

class _FeaturedCampaignCardState extends State<FeaturedCampaignCard> {
  late final theme = Theme.of(context).colorScheme;

  @override
  Widget build(BuildContext context) {
    final image = widget.item.featuredImage != null
        ? NetworkImage(widget.item.featuredImage!) as ImageProvider
        : AssetImage('assets/images/test.png');

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: theme.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _CampaignHeader(campaign: widget.item),
                _CardContent(
                  image: image,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Local Component: Campaign Header
class _CampaignHeader extends StatelessWidget {
  final Campaign campaign;

  const _CampaignHeader({required this.campaign});

  @override
  Widget build(BuildContext context) {
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
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Local Component: Card Content
class _CardContent extends StatelessWidget {
  final ImageProvider<Object> image;

  const _CardContent({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 184,
      height: 208,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image,
        ),
      ),
    );
  }
}
