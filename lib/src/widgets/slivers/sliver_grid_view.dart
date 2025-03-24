import 'package:flutter/material.dart';

class SliverGridView<T> extends StatelessWidget {
  final Widget? header;
  final EdgeInsetsGeometry padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final int crossAxisCount;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final Widget? Function(BuildContext context, int index, T item) itemBuilder;
  final List<T> items;
  final bool fillRow;
  final bool showLoader;
  final Widget? emptyPlaceholder;

  const SliverGridView({
    super.key,
    this.header,
    this.padding = EdgeInsets.zero,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    required this.itemBuilder,
    required this.crossAxisCount,
    this.fillRow = false,
    this.showLoader = true,
    this.emptyPlaceholder,
    required this.items,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final data = items.splitBeforeIndexed((i, v) => i % crossAxisCount == 0).toList();

    if (data.isNotEmpty) {
      return SliverPadding(
        padding: padding,
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, rowIndex) {
              final rowCount = fillRow ? data[rowIndex].length : crossAxisCount;
              return Row(
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: mainAxisAlignment,
                children: List.generate(
                  rowCount,
                  (columnIndex) {
                    final verticalPadding = mainAxisSpacing / 2;
                    final horizontalPadding = crossAxisSpacing / 2;
                    Widget item;
                    try {
                      item = itemBuilder(context, rowIndex, data[rowIndex][columnIndex])!;
                    } catch (e) {
                      item = const SizedBox();
                    }

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: rowIndex == 0 ? 10 : verticalPadding,
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
      );
    } else {
      if (emptyPlaceholder != null) {
        return SliverFillRemaining(child: emptyPlaceholder);
      }
      return SliverToBoxAdapter();
    }
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
