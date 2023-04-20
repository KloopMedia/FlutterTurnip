import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

import 'index.dart';

class SliverGridViewWithPagination<Data, Cubit extends RemoteDataCubit<Data>>
    extends StatelessWidget {
  final Widget? header;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final SliverGridDelegate gridDelegate;
  final int crossAxisCount;
  final Widget? Function(BuildContext context, int index, Data item) itemBuilder;

  const SliverGridViewWithPagination({
    Key? key,
    this.header,
    this.padding = EdgeInsets.zero,
    this.contentPadding = EdgeInsets.zero,
    required this.itemBuilder,
    required this.gridDelegate,
    required this.crossAxisCount,
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
          final data = state.data.splitBeforeIndexed((i, v) => i % 3 == 0).toList();
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: header),
              SliverPadding(
                padding: padding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Row(
                        children: List.generate(
                          data[index].length,
                          (i) => Expanded(
                            child: Padding(
                              padding: contentPadding,
                              child: itemBuilder(context, index, data[index][i])!,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: data.length,
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

extension on List {
  Iterable<List> splitBeforeIndexed(bool Function(int index, dynamic element) test) sync* {
    var iterator = this.iterator;
    if (!iterator.moveNext()) {
      return;
    }
    var index = 1;
    var chunk = [iterator.current];
    while (iterator.moveNext()) {
      var element = iterator.current;
      if (test(index++, element)) {
        yield chunk;
        chunk = [];
      }
      chunk.add(element);
    }
    yield chunk;
  }
}
