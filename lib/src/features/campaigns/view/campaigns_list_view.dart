import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/cards/title_card.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

typedef ItemCallback = void Function(Campaign item, bool join);
typedef RefreshCallback = void Function();

class CampaignsListView extends StatelessWidget {
  final List<Campaign> userCampaigns;
  final List<Campaign> availableCampaigns;
  final ItemCallback onTap;
  final RefreshCallback onRefresh;

  const CampaignsListView({
    Key? key,
    required this.onTap,
    required this.onRefresh,
    required this.userCampaigns,
    required this.availableCampaigns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = userCampaigns[index];
                return TitleCard(
                  title: item.name,
                  onTap: () {
                    onTap(item, false);
                  },
                );
              },
              childCount: userCampaigns.length,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = availableCampaigns[index];
                return TitleCard(
                  title: item.name,
                  onTap: () {
                    onTap(item, true);
                  },
                );
              },
              childCount: availableCampaigns.length,
            ),
          ),
        ],
      ),
    );
  }
}
