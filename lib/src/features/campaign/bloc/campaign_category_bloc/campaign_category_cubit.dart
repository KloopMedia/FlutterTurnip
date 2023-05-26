import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

part 'campaign_category_state.dart';

class CampaignCategoryCubit extends RemoteDataCubit<Category> {
  final CampaignCategoryRepository _repository;

  CampaignCategoryCubit(this._repository);

  @override
  Future<PageData<Category>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page);
  }
}