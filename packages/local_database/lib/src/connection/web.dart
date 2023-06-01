import 'package:drift/web.dart';

import '../../local_database.dart';

MyDatabase connect({bool isInWebWorker = false}) {
  return MyDatabase(WebDatabase('db'));
}
