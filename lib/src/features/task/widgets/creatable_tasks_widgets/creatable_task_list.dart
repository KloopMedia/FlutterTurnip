import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import 'creatable_task_card.dart';

class CreatableTaskList extends StatelessWidget {
  const CreatableTaskList({super.key});

  List<Widget> createTasks(BuildContext context, List<TaskStage> data) {
    BoxConstraints constraints;
    if (context.isSmall) {
      constraints = const BoxConstraints(minWidth: double.infinity);
    } else {
      constraints = const BoxConstraints(minWidth: 216, maxWidth: 340);
    }

    final List<Widget> items = data.map((item) {
      return CreatableTaskCard(
        title: item.name,
        constraints: constraints,
        onPressed: () => context.read<ReactiveTasks>().createTask(item),
      );
    }).toList();

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ProactiveTasksButtons, RemoteDataState<TaskStage>>(
        builder: (context, state) {
          if (state is RemoteDataLoaded<TaskStage> && state.data.isNotEmpty) {
            final items = createTasks(context, state.data);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 20,
                runSpacing: 20,
                children: items,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
