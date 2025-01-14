import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/routes/routes.dart';
import '../../../campaign_detail/bloc/campaign_detail_bloc.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
      builder: (context, state) {
        if (state is CampaignInitialized) {
          return IconButton(
            onPressed: () {
              final params = GoRouterState.of(context).pathParameters;
              context.pushNamed(SettingsRoute.name, pathParameters: params);
            },
            icon: const Icon(Icons.settings),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
