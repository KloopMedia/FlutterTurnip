import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

import '../../gigaturnip_repository.dart';
import '../models/volume.dart';

class VolumeRepository extends GigaTurnipRepository<Volume> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;
  final int campaignId;

  VolumeRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    required this.campaignId,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  List<Volume> parseData(List<api.Volume> data) {
    return data.map(Volume.fromApiModel).toList();
  }

  @override
  Future<api.PaginationWrapper<Volume>> fetchAndParseData({Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getVolumes(query: {
      'complete': true,
      'stage__chain__campaign': campaignId,
      ...?query,
    });
    return data.copyWith<Volume>(results: parseData(data.results));
  }
}
