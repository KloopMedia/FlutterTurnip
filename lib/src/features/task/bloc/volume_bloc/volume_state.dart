part of 'volume_cubit.dart';

class SelectedVolumeState extends Equatable {
  final Volume? volume;

  const SelectedVolumeState(this.volume);

  @override
  List<Object?> get props => [volume?.id];
}

class SelectedVolumeLoaded extends SelectedVolumeState {
  const SelectedVolumeLoaded(Volume? volume) : super(volume);
}