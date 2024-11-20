import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'volume_state.dart';

class VolumeCubit extends RemoteDataCubit<Volume> {
  final VolumeRepository _repository;

  VolumeCubit(this._repository);

  @override
  Future<PageData<Volume>> fetchAndParseData(
    int page, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) async {
    final volumes = await _repository.fetchDataOnPage(page, query);
    volumes.data.sort((a, b) => a.order.compareTo(b.order));
    final sortedVolumes = volumes.copyWith(data: volumes.data);
    return sortedVolumes;
  }
}

class SelectedVolumeCubit extends Cubit<SelectedVolumeState> {
  late final StreamSubscription _volumeSubscription;

  SelectedVolumeCubit({required Stream<RemoteDataState<Volume>> volumeSubscription})
      : super(const SelectedVolumeState(null)) {
    _volumeSubscription = volumeSubscription.listen(
      (volumeState) {
        if (volumeState is RemoteDataLoaded<Volume>) {
          Volume? currentVolume;
          try {
            currentVolume = volumeState.data.firstWhere(
              (volume) => volume.status == VolumeStatus.current,
              orElse: () => volumeState.data.first,
            );
          } catch (e) {
            currentVolume = null;
          }

          emit(SelectedVolumeLoaded(currentVolume));
        }
      },
    );
  }

  void selectVolume(Volume volume) {
    emit(SelectedVolumeState(volume));
  }

  @override
  Future<void> close() async {
    _volumeSubscription.cancel();
    super.close();
  }
}
