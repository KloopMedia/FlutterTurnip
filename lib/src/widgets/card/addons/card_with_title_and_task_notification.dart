import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/notification/bloc/notification_cubit.dart';
import 'package:gigaturnip/src/theme/screen_type.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../bloc/bloc.dart';

class CardWithTitleAndTaskNotification extends StatelessWidget {
  final Widget body;
  final int taskId;

  const CardWithTitleAndTaskNotification({
    Key? key,
    required this.body,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<OpenNotificationCubit, RemoteDataState<Notification>>(
        builder: (context, state) {
          if (state is RemoteDataFailed<Notification>) {
            return Center(child: Text(state.error));
          }
          if (state is RemoteDataInitialized<Notification>) {
            if (state.data.isNotEmpty) {
              bool containsReceiverTask = state.data.any((notification) => notification.receiverTask == taskId);
              if (containsReceiverTask) {
                final notificationWithReceiverTask = state.data.firstWhere((notification) => notification.receiverTask == taskId);
                if (taskId == notificationWithReceiverTask.receiverTask) {
                  return Container(
                    height: (context.isSmall || context.isMedium) ? 179 : 217,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: theme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x19454545),
                          blurRadius: 3,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0x19454545),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          spreadRadius: 3,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        body,
                        Container(
                          width: double.infinity,
                          height: 52,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  notificationWithReceiverTask.text,
                                  // 'Ваше обращение возвращено, откройте форму, чтобы узнать подробнее',
                                  style: TextStyle(
                                    color: theme.onSurfaceVariant,
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            }
            return body;
          }
          return const SizedBox.shrink();
        }
    );
  }
}
