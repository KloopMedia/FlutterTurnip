import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'user_activity_state.dart';

class UserActivityCubit extends RemoteDataCubit<UserActivity> {
  final UserActivityRepository _repository;

  UserActivityCubit(this._repository);

  @override
  Future<PageData<UserActivity>> fetchAndParseData(int page, {Map<String, dynamic>? body, Map<String, dynamic>? query}) {
    return _repository.fetchDataOnPage(page, query);
  }
}
