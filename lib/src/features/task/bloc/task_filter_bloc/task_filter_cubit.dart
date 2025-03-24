import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigaturnip/src/bloc/remote_data_bloc/remote_data_cubit.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:meta/meta.dart';

part 'task_filter_state.dart';

class TaskFilterCubit extends Cubit<TaskFilterState> {
  TaskFilterCubit({required Stream<RemoteDataState<Volume>> volumeSubscription})
      : super(TaskFilterState.initial()) {
    volumeSubscription.listen(
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

          emit(TaskFilterState(volume: currentVolume, taskQuery: state.taskQuery, chainQuery: state.chainQuery));
        }
      },
    );
  }

  void setVolume(Volume? volume) {
    emit(state.copyWith(volume: volume));
  }

  void updateAll({
    Map<String, dynamic>? taskQuery,
    Map<String, dynamic>? chainQuery,
    Volume? volume,
  }) {
    emit(state.copyWith(
      taskQuery: {...?taskQuery},
      chainQuery: {...?chainQuery},
      volume: volume,
    ));
  }
}
