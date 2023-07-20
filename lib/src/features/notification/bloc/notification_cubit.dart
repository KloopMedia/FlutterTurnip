import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'notification_state.dart';

mixin ClosedNotificationCubit on RemoteDataCubit<Notification> {}
mixin OpenNotificationCubit on RemoteDataCubit<Notification> {}

class NotificationCubit extends RemoteDataCubit<Notification> with ClosedNotificationCubit, OpenNotificationCubit {
  final NotificationRepository _repository;

  NotificationCubit(this._repository);

  @override
  Future<PageData<Notification>> fetchAndParseData(int page, [Map<String, dynamic>? query]) {
    return _repository.fetchDataOnPage(page, {'limit': 11});
  }
}
