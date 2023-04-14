import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

import '../../../widgets/list_view/index.dart';

class SliverGridViewWithPagination<Data, Cubit extends RemoteDataCubit<Data>>
    extends StatelessWidget {
  final Widget? header;
  final EdgeInsetsGeometry padding;
  final Widget? Function(BuildContext context, int index, Data item) itemBuilder;

  const SliverGridViewWithPagination({
    Key? key,
    this.header,
    this.padding = EdgeInsets.zero,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Cubit, RemoteDataState<Data>>(
      builder: (context, state) {
        if (state is RemoteDataLoading<Data>) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RemoteDataFailed<Data>) {
          return Center(child: Text(state.error));
        }
        if (state is RemoteDataLoaded<Data>) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: header),
              SliverPadding(
                padding: padding,
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) =>
                      itemBuilder(context, index, state.data[index]),
                    childCount: state.data.length,
                  ),
                ),
              ),
              SliverPadding(
                padding: padding,
                sliver: SliverToBoxAdapter(
                  child: Pagination(
                    currentPage: state.currentPage,
                    total: state.total,
                    onChanged: (page) => context.read<Cubit>().fetchData(page),
                    enabled: state is! RemoteDataLoading,
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}