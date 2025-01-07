import 'package:flutter/material.dart';

class CustomGridView<T> extends StatelessWidget {
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
  final ScrollPhysics? physics;
  final Widget? emptyPlaceholder;


  const CustomGridView({
    super.key,
    this.header,
    this.padding = EdgeInsets.zero,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    required this.itemBuilder,
    required this.crossAxisCount,
    this.fillRow = false,
    this.emptyPlaceholder,
    required this.items,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final data = items.splitBeforeIndexed((i, v) => i % crossAxisCount == 0).toList();

    if (data.isEmpty) {
      return emptyPlaceholder ?? SizedBox();
    }

    return ListView(
      padding: padding,
      physics: physics,
      children: [
        if (header != null) header!,
        ...data.map((row) {
          final rowCount = fillRow ? row.length : crossAxisCount;

          return Padding(
            padding: EdgeInsets.only(bottom: mainAxisSpacing),
            child: Row(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: mainAxisAlignment,
              children: List.generate(
                rowCount,
                (columnIndex) {
                  final horizontalPadding = crossAxisSpacing / 2;
                  Widget item;
                  try {
                    item = itemBuilder(context, columnIndex, row[columnIndex])!;
                  } catch (e) {
                    item = const SizedBox();
                  }

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: item,
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
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
