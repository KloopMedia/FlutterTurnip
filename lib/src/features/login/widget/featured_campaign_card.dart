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

    String title;
    if (widget.item.shortDescription != null && widget.item.shortDescription!.isNotEmpty) {
      title = widget.item.shortDescription!;
    } else {
      title = widget.item.name;
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 184,
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              _CampaignHeader(campaign: widget.item),
              Container(
                height: 208,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: widget.item.isCompleted ? Color(0xFFE7E7E7) : Color(0xFFFFDBC3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 8),
                    _CardContent(
                      image: image,
                    ),
                    SizedBox(height: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(height: 20),
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
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
      height: 128,
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image,
        ),
      ),
    );
  }
}
