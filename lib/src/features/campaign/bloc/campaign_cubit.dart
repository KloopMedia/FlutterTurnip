import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'campaign_state.dart';

mixin UserCampaignCubit on RemoteDataCubit<Campaign> {}
mixin SelectableCampaignCubit on RemoteDataCubit<Campaign> {}

class CampaignCubit extends RemoteDataCubit<Campaign> with UserCampaignCubit, SelectableCampaignCubit {
  final CampaignRepository _repository;

  CampaignCubit(this._repository);

  void openCampaignInfo(Campaign campaign) async {
    emit(CampaignInfo.clone(state as RemoteDataInitialized<Campaign>, campaign));
  }

  @override
  Future<PageData<Campaign>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page);
  }
}
