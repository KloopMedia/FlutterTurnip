import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:path/path.dart';
import 'package:uniturnip/json_schema_ui.dart';

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
    required Task task,
  }) : super(task.isIntegrated ? IntegratedTask(task: task) : CommonTask(task: task)) {
    on<InitializeTaskEvent>(onInitializeTaskEvent);
    on<UpdateTaskEvent>(onUpdateTaskEvent);
    on<SubmitTaskEvent>(onSubmitTaskEvent);
    on<ExitTaskEvent>(onExitTaskEvent);
    add(const InitializeTaskEvent());
  }

  void onInitializeTaskEvent(InitializeTaskEvent event, Emitter<TaskState> emit) async {
    final state = this.state;
    if (state is CommonTask) {
      final previousTasks = await gigaTurnipRepository.getPreviousTasks(state.task.id);
      emit(state.copyWith(task: state.task, previousTasks: previousTasks));
    }
    if (state is IntegratedTask) {
      final integratedTasks = await gigaTurnipRepository.getIntegratedTasks(state.task.id);
      emit(state.copyWith(task: state.task, integratedTasks: integratedTasks));
    }
  }

  void onUpdateTaskEvent(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    final task = state.task;
    final path = event.path;
    final formData = event.formData;

    final updatedTask = state.task.copyWith(responses: event.formData);

    if (task.isDynamic) {
      final dynamicMetadata = task.dynamicTarget!;
      final isDynamicMain = dynamicMetadata.first['main'] == path.last;
      final isDynamicForeign = (dynamicMetadata.first['foreign'] as List).contains(path.last);
      if (isDynamicMain || isDynamicForeign) {
        final schema = await gigaTurnipRepository.getDynamicJsonTaskStage(
          task.stage.id,
          task.id,
          formData,
        );
        updatedTask.copyWith(schema: schema);
      }
    }
    emit(state.copyWith(task: updatedTask));
  }

  void onSubmitTaskEvent(SubmitTaskEvent event, Emitter<TaskState> emit) {
    final task = state.task.copyWith(responses: event.formData, complete: true);
    emit(state.copyWith(task: task));
  }

  void onExitTaskEvent(ExitTaskEvent event, Emitter<TaskState> emit) {}

  void _saveTask(Task task) {
    gigaTurnipRepository.updateTask(task);
  }

  // TODO: Remove all file related code, when we finish integrating new form package (Flutter-jsonschema-form)

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

  String? _getContentType(FileType type, String extension) {
    switch (type) {
      case FileType.video:
        return 'video/$extension';
      case FileType.image:
        return 'image/$extension';
      default:
        return null;
    }
  }

  Future<firebase_storage.UploadTask?> uploadFile({
    required XFile? file,
    required String? path,
    required FileType type,
    required bool private,
  }) async {
    if (file == null) {
      return null;
    }
    final rawFile = await file.readAsBytes();
    final mimeType = file.mimeType ?? _getContentType(type, extension(file.name));

    if (kIsWeb || path == null) {
      return _uploadFile(
        file: rawFile,
        private: private,
        filename: file.name,
        mimeType: mimeType,
      );
    }

    Uint8List? compressed = rawFile;

    if (type == FileType.image) {
      compressed = await _compressImage(file);
    }
    // else if (type == FileType.video) {
    //   compressed = await _compressVideo(file);
    // }
    if (compressed != null) {
      return _uploadFile(
        file: compressed,
        private: private,
        filename: file.name,
        mimeType: mimeType,
      );
    } else {
      print('No compressed files');
      return null;
    }
  }

  Future<firebase_storage.UploadTask?> _uploadFile({
    required Uint8List file,
    required bool private,
    required String filename,
    required String? mimeType,
  }) async {
    final prefix = private ? 'private' : 'public';
    final storagePath = '$prefix/'
        '${state.task.stage.chain.campaign}/'
        '${state.task.stage.chain.id}/'
        '${state.task.stage.id}/'
        '${user.id}/'
        '${state.task.id}/'
        '$filename';

    final metadata = firebase_storage.SettableMetadata(contentType: mimeType);

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(storagePath);
      firebase_storage.UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(file, metadata);
      } else {
        uploadTask = ref.putData(file, metadata);
      }
      return Future.value(uploadTask);
    } on firebase_storage.FirebaseException catch (e) {
      print('FIlE UPLOAD ERROR ---> $e');
      rethrow;
    }
  }

  // Future<Uint8List?> _compressVideo(XFile file) async {
  //   MediaInfo? mediaInfo = await VideoCompress.compressVideo(
  //     file.path,
  //     quality: VideoQuality.DefaultQuality,
  //   );
  //   return mediaInfo?.file?.readAsBytesSync();
  // }

  Future<Uint8List?> _compressImage(XFile file) async {
    return await FlutterImageCompress.compressWithFile(file.path);
  }
}
