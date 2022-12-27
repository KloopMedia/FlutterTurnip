import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/tasks/features/list_tasks/cubit/index.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return SizedBox(
            width: 25,
            height: 25,
            child: Stack(
                children: [
                  const Icon(Icons.notifications, color: Colors.grey),
                  (state.hasUnreadNotifications)
                      ? Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                      )
                  )
                      : const SizedBox.shrink()
                ]
            ),
          );
        }
    );
  }
}