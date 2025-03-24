import 'dart:async';

import 'package:equatable/equatable.dart';
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
