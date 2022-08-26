import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart' show UploadTask;
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:path/path.dart';
import 'package:uniturnip/json_schema_ui.dart';
import 'package:video_compress/video_compress.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GigaTurnipRepository gigaTurnipRepository;
  final AuthUser user;
  Timer? timer;
  TaskState? _cache;

  TaskBloc({
    required this.gigaTurnipRepository,
    required this.user,
    required Task selectedTask,
  }) : super(TaskState.fromTask(selectedTask, TaskStatus.initialized)) {
    timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (_cache != state) {
        _cache = state;
        _saveTask(state);
      }
    });
    on<InitializeTaskEvent>(_onInitializeTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<SubmitTaskEvent>(_onSubmitTask);
    on<ExitTaskEvent>(_onExitTask);
  }

  Future<Task> _getTask(int id) async {
    return await gigaTurnipRepository.getTask(id);
  }

  Future<int?> _saveTask(Task task) async {
    if (!state.complete) {
      return await gigaTurnipRepository.updateTask(task);
    }
    return null;
  }

  Future<List<Task>> _getPreviousTasks(int id) async {
    return gigaTurnipRepository.getPreviousTasks(id);
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    emit(state.copyWith(responses: event.formData));
  }

  void _onSubmitTask(SubmitTaskEvent event, Emitter<TaskState> emit) async {
    final newState = state.copyWith(responses: event.formData, complete: true);
    final nextTaskId = await _saveTask(newState);
    if (nextTaskId != null) {
      final nextTask = await _getTask(nextTaskId);
      emit(newState.copyWith(taskStatus: TaskStatus.redirectToNextTask, nextTask: nextTask));
    } else {
      emit(newState.copyWith(taskStatus: TaskStatus.redirectToTasksList));
    }
  }

  void _onExitTask(ExitTaskEvent event, Emitter<TaskState> emit) async {
    await _saveTask(state);
    emit(state.copyWith(taskStatus: TaskStatus.redirectToTasksList));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  Future<void> _onInitializeTask(InitializeTaskEvent event, Emitter<TaskState> emit) async {
    final previousTasks = await _getPreviousTasks(state.id);
    emit(state.copyWith(previousTasks: previousTasks));
  }

  Future<FileModel> getFile(path) async {
    final ref = firebase_storage.FirebaseStorage.instance.ref(path);
    final data = await ref.getMetadata();
    final url = await ref.getDownloadURL();
    final type = _getFileType(data.contentType);
    return FileModel(name: data.name, path: data.fullPath, type: type, url: url);
  }

  FileType _getFileType(String? contentType) {
    final type = contentType?.split('/').first;
    switch (type) {
      case 'video':
        return FileType.video;
      case 'image':
        return FileType.image;
      default:
        return FileType.any;
    }
  }

  Future<UploadTask?> uploadFile(String path, FileType type, bool private) async {
    String filename = basename(path);
    final prefix = private ? 'private' : 'public';
    final storagePath = '$prefix/'
        '${state.stage.chain.campaign}/'
        '${state.stage.chain.id}/'
        '${state.stage.id}/'
        '${user.id}/'
        '${state.id}/'
        '$filename';

    File file = File(path);
    File? compressed = file;

    if (type == FileType.image) {
      compressed = await _compressImage(file);
    } else if (type == FileType.video) {
      compressed = await _compressVideo(file);
    }
    if (compressed != null) {
      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref(storagePath);
        return ref.putFile(compressed);
      } on firebase_storage.FirebaseException catch (e) {
        print(e);
        rethrow;
      }
    } else {
      print('No compressed files');
      return null;
    }
  }

  Future<File?> _compressVideo(File file) async {
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.DefaultQuality,
    );
    return mediaInfo?.file;
  }

  Future<File?> _compressImage(File file) async {
    final result = await FlutterImageCompress.compressWithFile(file.absolute.path);
    return File(file.absolute.path).writeAsBytes(result!, flush: true);
  }
}
