import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';

class AvailableCampaignCard extends StatelessWidget {
  final Campaign campaign;

  const AvailableCampaignCard({
    super.key,
    required this.campaign,
  });

  Future<void> _handleCampaignSelection(BuildContext context, Campaign campaign) async {
    final client = context.read<api.GigaTurnipApiClient>();

    try {
      await client.joinCampaign(campaign.id);

      final registrationStage = campaign.registrationStage;

      if (registrationStage == null || !context.mounted) {
        _navigateToTaskRoute(context, campaign.id);
        return;
      }

      try {
        final task = await client.createTaskFromStageId(registrationStage);
        if (context.mounted) {
          _navigateToTaskDetail(context, campaign.id, task.id);
        }
      } catch (e) {
        print(e);
        _navigateToTaskRoute(context, campaign.id);
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        content: Text("Error: $e"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _navigateToTaskDetail(BuildContext context, int campaignId, int taskId) {
    context.goNamed(TaskDetailRoute.name, pathParameters: {
      'cid': "$campaignId",
      'tid': taskId.toString(),
    });
  }

  void _navigateToTaskRoute(BuildContext context, int campaignId) {
    context.goNamed(TaskRoute.name, pathParameters: {
      'cid': "$campaignId",
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final hasImage = campaign.featuredImage != null && campaign.featuredImage!.isNotEmpty;

    return Container(
      width: 320,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Color(0xFFDCE1FF), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: hasImage ? 238 : 300,
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
                    ),
                    SizedBox(
                      height: 63,
                      child: Text(
                        campaign.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
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
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () => _handleCampaignSelection(context, campaign),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: theme.primary,
                    ),
                    child: Text(
                      context.loc.join,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
