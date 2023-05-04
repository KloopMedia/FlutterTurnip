import 'package:flutter/material.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';

class AdaptiveListView<Data, Cubit extends RemoteDataCubit<Data>> extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double contentPadding;
  final bool fillRow;
  final Widget Function(BuildContext context, int index, Data item) itemBuilder;

  const AdaptiveListView({
    Key? key,
    required this.itemBuilder,
    this.padding = EdgeInsets.zero,
    this.crossAxisCount = 3,
    this.mainAxisSpacing = 30,
    this.crossAxisSpacing = 20,
    this.contentPadding = 10,
    this.fillRow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop || context.isTablet) {
      return SliverGridViewWithPagination<Data, Cubit>(
        padding: padding,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        crossAxisCount: crossAxisCount,
        itemBuilder: itemBuilder,
        fillRow: fillRow,
      );
    } else {
      return SliverListViewWithPagination<Data, Cubit>(
        padding: padding,
        contentPadding: EdgeInsets.symmetric(vertical: contentPadding),
        itemBuilder: itemBuilder,
      );
    }
  }
}
