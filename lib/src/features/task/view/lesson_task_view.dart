import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../bloc/bloc.dart';
import '../bloc/bloc.dart';
import '../utils.dart';
import '../widgets/widgets.dart';

class LessonTaskPage extends StatelessWidget {
  final Function(TaskStageChainInfo item, ChainInfoStatus status) onTap;

  const LessonTaskPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndividualChainCubit, RemoteDataState<IndividualChain>>(
      builder: (context, state) {
        if (state is RemoteDataLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is RemoteDataFailed) {
          return const SliverToBoxAdapter(child: SizedBox());
        }

        if (state is RemoteDataInitialized<IndividualChain> && state.data.isNotEmpty) {
          final chains = buildChains(state.data, onTap);
          return SliverList.list(children: chains);
        }

        return const SliverToBoxAdapter(
          child: SizedBox(),
        );
      },
    );
  }
}
