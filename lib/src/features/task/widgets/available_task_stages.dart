import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'avatar_button.dart';

class AvailableTaskStages extends StatelessWidget {
  final void Function(TaskStage item) onTap;

  const AvailableTaskStages({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableTaskStageCubit, RemoteDataState<TaskStage>>(
      builder: (context, state) {
        if (state is RemoteDataLoaded<TaskStage> && state.data.isNotEmpty) {
          return MultiSliver(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
                child: Text(
                  'Доступные задания',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
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
                        url:
                            'https://is4-ssl.mzstatic.com/image/thumb/Purple116/v4/77/29/8a/77298a50-f7d9-07a4-9c17-d55b57a1e812/logo_gsa_ios_color-0-1x_U007emarketing-0-0-0-6-0-0-0-85-220-0.png/246x0w.webp',
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
