import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

firebase_storage.Reference generateStorageReference(dynamic task, User user) {
  if (task is TaskDetail || task is Task) {
    final campaignId = task.stage.campaign;
    final chainId = task.stage.chain;
    final stageId = task.stage.id;
    final taskId = task.id;
    final userId = user.id;

    return firebase_storage.FirebaseStorage.instance
        .ref('$campaignId/$chainId/$stageId/$userId/$taskId');
  }

  throw Exception('Parameter [task] is not TaskDetail or Task');
}