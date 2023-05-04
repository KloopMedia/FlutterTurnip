import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';

import '../bloc/bloc.dart';
import 'creatable_task_menu.dart';

class TaskPageFloatingActionButton extends StatelessWidget {
  final int campaignId;

  const TaskPageFloatingActionButton({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: context.isMobile ? 50 : 84, right: 8),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: theme.primary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<CreatableTaskCubit>(),
                  child: CreatableTaskMenu(campaignId: campaignId),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
