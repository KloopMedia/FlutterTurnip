import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/widgets/app_bar/new_scaffold_appbar.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';
import '../bloc/bloc.dart';
import '../utils.dart';
import '../widgets/task_chain_widgets/types.dart';

class BookChainView extends StatefulWidget {
  const BookChainView({super.key});

  @override
  State<BookChainView> createState() => _BookChainViewState();
}

class _BookChainViewState extends State<BookChainView> {
  void handleTap(TaskStageChainInfo item, ChainInfoStatus status) {
    if (item.richText != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return WebView(
              html: item.richText,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookChainCubit, RemoteDataState<IndividualChain>>(
      builder: (context, state) {
        if (state is RemoteDataLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is RemoteDataFailed) {
          return SizedBox();
        }

        if (state is RemoteDataInitialized<IndividualChain> && state.data.isNotEmpty) {
          final chains = buildChains(state.data, handleTap);
          return ListView(children: chains);
        }

        return SizedBox();
      },
    );
  }
}
