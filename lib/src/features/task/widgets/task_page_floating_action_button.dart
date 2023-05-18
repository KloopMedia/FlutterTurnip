import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../bloc/bloc.dart';
import 'creatable_task_menu.dart';

class TaskPageFloatingActionButton extends StatelessWidget {
  final int campaignId;

  const TaskPageFloatingActionButton({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<ProactiveTasks, RemoteDataState<TaskStage>>(
      builder: (context, state) {
        if (state is RemoteDataInitialized<TaskStage> && state.data.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 8),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              backgroundColor: theme.primary,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: context.read<ProactiveTasks>(),
                      child: CreatableTaskMenu(campaignId: campaignId),
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
