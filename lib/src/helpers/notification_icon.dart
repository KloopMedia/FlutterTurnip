import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/notification/bloc/notification_cubit.dart';
import '../bloc/remote_data_bloc/remote_data_cubit.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<NotificationCubit, RemoteDataCubit<Notification>>(
    //     builder: (context, state) {
          return SizedBox(
            width: 25,
            height: 25,
            child: Stack(
                children: [
                  Icon(Icons.notifications, color: Colors.blueGrey.shade100),
                  // (state.hasData)
                      Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                      )
                  )
                      // : const SizedBox.shrink()
                ]
            ),
          );
        // }
    // );
  }
}