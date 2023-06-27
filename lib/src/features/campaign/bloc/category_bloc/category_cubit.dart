import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

part 'category_state.dart';

class CategoryCubit extends RemoteDataCubit<Category> {
  final CategoryRepository _repository;

  CategoryCubit(this._repository);

  @override
  Future<PageData<Category>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page);
  }
}