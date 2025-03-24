import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/widgets/section_header.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'avatar_button.dart';

class AvailableTaskStages extends StatelessWidget {
  final void Function(TaskStage item) onTap;

  const AvailableTaskStages({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableTaskStageCubit, RemoteDataState<TaskStage>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<TaskStage> && state.data.isNotEmpty) {
          return MultiSliver(
            children: [
              SectionHeader(context.loc.task_available),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  itemBuilder: (context, index) {
                    final item = state.data[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: AvatarButton(
                        url: null,
                        text: item.name,
                        onTap: () => onTap(item),
                      ),
                    );
                  },
                  itemCount: state.data.length,
                ),
              )
            ],
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
