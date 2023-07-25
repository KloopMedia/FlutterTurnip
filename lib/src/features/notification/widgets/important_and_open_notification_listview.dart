import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/notification/bloc/notification_cubit.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class ImportantAndOpenNotificationListView extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final int? importantNotificationCount;
  final Widget? Function(BuildContext context, Notification item) itemBuilder;

  const ImportantAndOpenNotificationListView({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.contentPadding = EdgeInsets.zero,
    this.importantNotificationCount,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenNotificationCubit, RemoteDataState<Notification>>(
      builder: (context, state) {
        if (state is RemoteDataFailed<Notification>) {
          return SliverToBoxAdapter(child: Center(child: Text(state.error)));
        }
        if (state is RemoteDataInitialized<Notification>) {
          if (state.data.isNotEmpty) {
            List data = [];
            if (importantNotificationCount == null) {
              data = state.data.where((item) => item.importance > 0).toList();
            } else {
              bool containsImportantNotification = state.data.any((item) => item.importance == 0);
              if (containsImportantNotification) data = [state.data.firstWhere((item) => item.importance == 0)];
            }
            if (data.isNotEmpty) {
              if (importantNotificationCount != null) {
                if (context.isExtraLarge || context.isLarge) {
                  return SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15
                          ),
                          child: itemBuilder(context, data[0])!,
                        ),
                        const Spacer()
                      ],
                    ),
                  );
                }
              }
              return SliverPadding(
                padding: padding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: contentPadding,
                      child: itemBuilder(context, data[index]),
                    ),
                    childCount: importantNotificationCount ?? data.length,
                  ),
                ),
              );
            } else {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }
          }
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}