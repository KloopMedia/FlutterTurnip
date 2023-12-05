import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/chain/bloc/chain_cubit.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/button/custom_floating_action_button.dart';
import 'package:gigaturnip/src/widgets/slivers/adaptive_list_view.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../widgets/chain_card.dart';

class ChainPage extends StatefulWidget {
  final int campaignId;

  const ChainPage({super.key, required this.campaignId});

  @override
  State<ChainPage> createState() => _ChainPageState();
}

class _ChainPageState extends State<ChainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChainCubit(
        ChainRepository(
          campaignId: widget.campaignId,
          gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
        ),
      )..initialize(),
      child: ChainView(),
    );
  }
}

class ChainView extends StatelessWidget {
  const ChainView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      title: Text(context.loc.chains),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {},
      ),
      child: CustomScrollView(
        slivers: [
          AdaptiveListView<Chain, ChainCubit>(
            padding: const EdgeInsets.all(24),
            mainAxisSpacing: 20,
            itemBuilder: (context, state, item) {
              return ChainCard(
                title: item.name,
                description: item.description,
                onTap: () {},
              );
            },
          )
        ],
      ),
    );
  }
}