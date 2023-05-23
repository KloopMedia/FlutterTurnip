import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

abstract class ChainRepository extends GigaTurnipRepository<api.Chain, Chain> {
  final api.GigaTurnipApiClient _gigaTurnipApiClient;

  ChainRepository({
    required api.GigaTurnipApiClient gigaTurnipApiClient,
    super.limit,
  }) : _gigaTurnipApiClient = gigaTurnipApiClient;

  @override
  List<Chain> parseData(List<api.Chain> data) {
    return data.map(Chain.fromApiModel).toList();
  }
}

class IndividualChainRepository extends ChainRepository {
  IndividualChainRepository({required super.gigaTurnipApiClient, super.limit});

  @override
  Future<api.PaginationWrapper<api.Chain>> fetchData({Map<String, dynamic>? query}) async {
    return _gigaTurnipApiClient.getChains(query: {
      'is_individual': true,
      ...?query,
    });
  }
}