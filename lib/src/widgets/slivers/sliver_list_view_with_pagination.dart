import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'pagination.dart';

class SliverListViewWithPagination<Data, Cubit extends RemoteDataCubit<Data>>
    extends StatelessWidget {
  final Widget? header;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final Widget? Function(BuildContext context, int index, Data item) itemBuilder;
  final bool showLoader;
  final Widget? emptyPlaceholder;

  const SliverListViewWithPagination({
    Key? key,
    this.header,
    this.padding = EdgeInsets.zero,
    this.contentPadding = EdgeInsets.zero,
    required this.itemBuilder,
    this.showLoader = true,
    this.emptyPlaceholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Cubit, RemoteDataState<Data>>(
      builder: (context, state) {
        if (state is RemoteDataLoading<Data> && showLoader) {
          return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
        }
        if (state is RemoteDataFailed<Data>) {
          return SliverToBoxAdapter(child: Center(child: Text(state.error)));
        }
        if (state is RemoteDataInitialized<Data>) {
          if (state.data.isNotEmpty) {
            return MultiSliver(children: [
              SliverToBoxAdapter(child: header),
              SliverPadding(
                padding: padding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: contentPadding,
                      child: itemBuilder(context, index, state.data[index]),
                    ),
                    childCount: state.data.length,
                  ),
                ),
              ),
              SliverPadding(
                padding: state.total == 0 ? EdgeInsets.zero : padding,
                sliver: SliverToBoxAdapter(
                  child: Pagination(
                    currentPage: state.currentPage,
                    total: state.total,
                    onChanged: (page) => context.read<Cubit>().fetchData(page),
                    enabled: state is! RemoteDataLoading,
                  ),
                ),
              ),
            ]);
          } else {
            return SliverFillRemaining(child: emptyPlaceholder);
          }
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
