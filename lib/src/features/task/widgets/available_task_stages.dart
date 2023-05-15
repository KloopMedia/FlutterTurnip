import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'avatar_button.dart';

class AvailableTaskStages extends StatelessWidget {
  final void Function(TaskStage item) onTap;

  const AvailableTaskStages({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<SelectableTaskStageCubit, RemoteDataState<TaskStage>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<TaskStage> && state.data.isNotEmpty) {
          return MultiSliver(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
                child: Text(
                  context.loc.task_available,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: theme.isLight ? theme.neutral30 : theme.neutral90),
                ),
              ),
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
