import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

class IndividualChainRepository extends GigaTurnipRepository<IndividualChain> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;
  final int campaignId;

  IndividualChainRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    required this.campaignId,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  Future<api.PaginationWrapper<IndividualChain>> fetchAndParseData(
      {Map<String, dynamic>? query}) async {
    final data = await _gigaTurnipApiClient.getIndividualChains(query: {
      'campaign': campaignId,
      'is_individual': true,
      ...?query,
    });

    return data.copyWith<IndividualChain>(count: data.count, results: parseData(data.results));
  }

  List<IndividualChain> parseData(List<api.IndividualChain> data) {
    return data.map(IndividualChain.fromApiModel).toList();
  }

  Future<int> createTask(int id) async {
    final response = await _gigaTurnipApiClient.createTaskFromStageId(id);
    return response.id;
  }
}
