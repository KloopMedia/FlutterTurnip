import 'package:gigaturnip_api/gigaturnip_api.dart';

import 'campaign_repository.dart';

class GigaTurnipRepository {
  final GigaTurnipApiClient _gigaTurnipApiClient;

  const GigaTurnipRepository(GigaTurnipApiClient gigaTurnipApiClient)
      : _gigaTurnipApiClient = gigaTurnipApiClient;

  CampaignRepository campaign() => CampaignRepository(_gigaTurnipApiClient);
}
