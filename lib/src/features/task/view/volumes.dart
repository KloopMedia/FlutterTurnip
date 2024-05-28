import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../bloc/volume_bloc/volume_cubit.dart';
import '../widgets/volume_card.dart';

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
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder(
        bloc: context.read<VolumeCubit>(),
        builder: (context, state) {
          if (state is RemoteDataLoading<Volume>) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RemoteDataLoaded) {
            final volumes = state.data;
            return ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 24),
              shape: const Border(),
              title: Text(
                context.read<SelectedVolumeCubit>().state.volume?.name ?? context.loc.volume,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xFF444748),
                ),
              ),
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 141),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    itemCount: volumes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final volume = volumes[index];
                      return BlocBuilder<SelectedVolumeCubit, SelectedVolumeState>(
                        builder: (context, selectedVolumeState) {
                          return VolumeCard(
                            name: volume.name,
                            description: volume.description,
                            isSelected: selectedVolumeState.volume?.id == volume.id,
                            index: index,
                            onTap: () {
                              widget.onChanged(volume);
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 8);
                    },
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
