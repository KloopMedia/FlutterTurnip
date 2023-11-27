import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/utilities/constants.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'campaign_state.dart';

mixin UserCampaignCubit on RemoteDataCubit<Campaign> {}
mixin SelectableCampaignCubit on RemoteDataCubit<Campaign> {}

class CampaignCubit extends RemoteDataCubit<Campaign> with UserCampaignCubit, SelectableCampaignCubit {
  final CampaignRepository _repository;
  final SharedPreferences _sharedPreferences;

  CampaignCubit(this._repository, this._sharedPreferences);

  void openCampaignInfo(Campaign campaign) async {
    emit(CampaignInfo.clone(state as RemoteDataInitialized<Campaign>, campaign));
  }

  @override
  Future<PageData<Campaign>> fetchAndParseData(int page, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  }) {
    final selectedCountry = _sharedPreferences.getStringList(Constants.sharedPrefCountryKey);
    final firstTimeCountry = _sharedPreferences.getBool(Constants.sharedPrefFirstTimeCountryKey);
    if (selectedCountry != null && selectedCountry.isNotEmpty && firstTimeCountry != null && firstTimeCountry) {
      final countryQuery = {'countries__name': selectedCountry[1]};
      return _repository.fetchDataOnPage(page, countryQuery);
    } else {
      return _repository.fetchDataOnPage(page, query);
    }
  }
}
