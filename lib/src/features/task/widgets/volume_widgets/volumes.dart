import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/task_filter_bloc/task_filter_cubit.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../bloc/volume_bloc/volume_cubit.dart';
import 'volume_card.dart';

class Volumes extends StatefulWidget {
  final void Function(Volume volume) onChanged;

  const Volumes({
    super.key,
    required this.onChanged,
  });

  @override
  State<Volumes> createState() => _VolumesState();
}

class _VolumesState extends State<Volumes> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<VolumeCubit, RemoteDataState<Volume>>(
        builder: (context, state) {
          if (state is RemoteDataLoading<Volume>) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is RemoteDataLoaded<Volume>) {
            final volumes = state.data;
            if (volumes.isEmpty) {
              return const SizedBox();
            }

            return BlocBuilder<TaskFilterCubit, TaskFilterState>(
              builder: (context, filterState) {
                final selectedVolume = filterState.volume;
                final selectedVolumeIndex = volumes.indexWhere((v) => v.id == selectedVolume?.id);

                return Container(
                  margin: const EdgeInsets.only(top: 11),
                  constraints: const BoxConstraints(maxHeight: 141),
                  child: ScrollablePositionedList.separated(
                    initialScrollIndex: selectedVolumeIndex >= 0 ? selectedVolumeIndex : 0,
                    itemScrollController: _itemScrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    itemCount: volumes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final volume = volumes[index];
                      final isSelected = volume.id == selectedVolume?.id;

                      return VolumeCard(
                        status: volume.status,
                        name: volume.name,
                        description: volume.description,
                        isSelected: isSelected,
                        index: index,
                        onTap: () => widget.onChanged(volume),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
                  ),
                );
              },
            );
          }

          // If state is neither loading nor loaded, just return empty
          return const SizedBox();
        },
      ),
    );
  }
}