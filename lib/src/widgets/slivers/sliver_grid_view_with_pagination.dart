import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'index.dart';

class SliverGridViewWithPagination<Data, Cubit extends RemoteDataCubit<Data>>
    extends StatelessWidget {
  final Widget? header;
  final EdgeInsetsGeometry padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final int crossAxisCount;
  final Widget? Function(BuildContext context, int index, Data item) itemBuilder;
  final bool fillRow;
  final bool showLoader;
  final Widget? emptyPlaceholder;

  const SliverGridViewWithPagination({
    Key? key,
    this.header,
    this.padding = EdgeInsets.zero,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    required this.itemBuilder,
    required this.crossAxisCount,
    this.fillRow = false,
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
        if (state is RemoteDataLoaded<Data>) {
          if (state.data.isNotEmpty) {
            final data = state.data.splitBeforeIndexed((i, v) => i % crossAxisCount == 0).toList();
            return MultiSliver(children: [
              SliverToBoxAdapter(child: header),
              SliverPadding(
                padding: padding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, rowIndex) {
                      final rowCount = fillRow ? data[rowIndex].length : crossAxisCount;
                      return Row(
                        children: List.generate(
                          rowCount,
                          (columnIndex) {
                            final verticalPadding = mainAxisSpacing / 2;
                            final horizontalPadding = crossAxisSpacing / 2;
                            var item;
                            try {
                              item = itemBuilder(context, rowIndex, data[rowIndex][columnIndex])!;
                            } catch (e) {
                              item = const SizedBox();
                            }

                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: rowIndex == 0 ? 0 : verticalPadding,
                                  bottom: rowIndex == data.length - 1 ? 0 : verticalPadding,
                                  left: columnIndex == 0 ? 0 : horizontalPadding,
                                  right: columnIndex == rowCount - 1 ? 0 : horizontalPadding,
                                ),
                                child: item,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    childCount: data.length,
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
            if (emptyPlaceholder != null) {
              return SliverFillRemaining(child: emptyPlaceholder);
            }
          }
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
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
