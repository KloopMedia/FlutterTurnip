import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart' show SettableMetadata, UploadTask;
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:path/path.dart';
// import 'package:uniturnip/json_schema_ui.dart';
// import 'package:video_compress/video_compress.dart';

part 'task_event.dart';

part 'task_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GigaTurnipRepository gigaTurnipRepository;
  final AuthUser user;
  Timer? timer;
  TaskState? _cache;
  // firebase_storage.Reference? storage;

  TaskBloc({
    required this.gigaTurnipRepository,
    required this.user,
    required Task selectedTask,
    // this.storage,
  }) : super(TaskState.fromTask(selectedTask, TaskStatus.initialized)) {
    timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (_cache != state && !state.complete) {
        _cache = state;
        _saveTask(state);
      }
    });
    on<InitializeTaskEvent>(_onInitializeTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<SubmitTaskEvent>(_onSubmitTask);
    on<ExitTaskEvent>(_onExitTask);
    on<GetDynamicSchemaTaskEvent>(_onGetDynamicSchema);
    on<GenerateIntegratedForm>(_onGenerateIntegratedForm);
    on<UpdateIntegratedTask>(_onUpdateIntegratedTask,
        transformer: debounce(const Duration(milliseconds: 300)));
    final dynamicJsonMetadata = state.stage.dynamicJsonsTarget;
    if (dynamicJsonMetadata != null && dynamicJsonMetadata.isNotEmpty) {
      add(GetDynamicSchemaTaskEvent(state.responses ?? {}));
    }
    // storage = firebase_storage.FirebaseStorage.instance.ref('${state.stage.chain.campaign}/'
    //     '${state.stage.chain.id}/'
    //     '${state.stage.id}/'
    //     '${user.id}/'
    //     '${state.id}');
  }

  Future<Map<String, dynamic>> getDynamicJson(
      int id, int taskId, Map<String, dynamic>? data) async {
    return await gigaTurnipRepository.getDynamicJsonTaskStage(id, taskId, data);
  }

  Future<List<Task>> getIntegratedTasks(int id) async {
    return await gigaTurnipRepository.getIntegratedTasks(id);
  }

  Future<Task> _getTask(int id) async {
    return await gigaTurnipRepository.getTask(id);
  }

  Future<int?> _saveTask(Task task) async {
    return await gigaTurnipRepository.updateTask(task);
  }

  Future<List<Task>> _getPreviousTasks(int id) async {
    return gigaTurnipRepository.getPreviousTasks(id);
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) {
    emit(state.copyWith(responses: event.formData));
  }

  void _onSubmitTask(SubmitTaskEvent event, Emitter<TaskState> emit) async {
    final newState = state.copyWith(responses: event.formData, complete: true);
    emit(newState);
    print('submit');
    final nextTaskId = await _saveTask(newState);
    if (nextTaskId != null) {
      final nextTask = await _getTask(nextTaskId);
      emit(newState.copyWith(taskStatus: TaskStatus.redirectToNextTask, nextTask: nextTask));
    } else {
      emit(newState.copyWith(taskStatus: TaskStatus.redirectToTasksList));
    }
  }

  void _onExitTask(ExitTaskEvent event, Emitter<TaskState> emit) async {
    if (!state.complete) {
      await _saveTask(state);
    }
    emit(state.copyWith(taskStatus: TaskStatus.redirectToTasksList));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  Future<void> _onInitializeTask(InitializeTaskEvent event, Emitter<TaskState> emit) async {
    final previousTasks = await _getPreviousTasks(state.id);
    final List<Task> integratedTasks = state.isIntegrated ? await getIntegratedTasks(state.id) : [];

    emit(state.copyWith(previousTasks: previousTasks, integratedTasks: integratedTasks));
  }

  // Future<FileModel> getFile(path) async {
  //   final ref = firebase_storage.FirebaseStorage.instance.ref(path);
  //   final data = await ref.getMetadata();
  //   final url = await ref.getDownloadURL();
  //   final type = _getFileType(data.contentType);
  //   return FileModel(name: data.name, path: data.fullPath, type: type, url: url);
  // }

  // FileType _getFileType(String? contentType) {
  //   final type = contentType?.split('/').first;
  //   switch (type) {
  //     case 'video':
  //       return FileType.video;
  //     case 'image':
  //       return FileType.image;
  //     default:
  //       return FileType.any;
  //   }
  // }

  // String? _getContentType(FileType type, String extension) {
  //   switch (type) {
  //     case FileType.video:
  //       return 'video/$extension';
  //     case FileType.image:
  //       return 'image/$extension';
  //     default:
  //       return null;
  //   }
  // }

  String createStoragePathFromTask(Task task) {
    return '${task.stage.chain.campaign}/'
        '${task.stage.chain.id}/'
        '${task.stage.id}/'
        '${user.id}/'
        '${task.id}';
  }

  // Future<UploadTask?> uploadFile({
  //   required XFile? file,
  //   required String? path,
  //   required FileType type,
  //   required bool private,
  //   required Task task,
  // }) async {
  //   if (file == null) {
  //     return null;
  //   }
  //   final rawFile = await file.readAsBytes();
  //   final mimeType = file.mimeType ?? _getContentType(type, extension(file.name));
  //
  //   if (kIsWeb || path == null) {
  //     return _uploadFile(
  //         file: rawFile, private: private, filename: file.name, mimeType: mimeType, task: task);
  //   }
  //
  //   Uint8List? compressed = rawFile;
  //
  //   if (type == FileType.image) {
  //     compressed = await _compressImage(file);
  //   }
  //   // else if (type == FileType.video) {
  //   //   compressed = await _compressVideo(file);
  //   // }
  //   if (compressed != null) {
  //     return _uploadFile(
  //       file: compressed,
  //       private: private,
  //       filename: file.name,
  //       mimeType: mimeType,
  //       task: task,
  //     );
  //   } else {
  //     print('No compressed files');
  //     return null;
  //   }
  // }

  Future<UploadTask?> _uploadFile({
    required Uint8List file,
    required bool private,
    required String filename,
    required String? mimeType,
    required Task task,
  }) async {
    final prefix = private ? 'private' : 'public';
    final path = createStoragePathFromTask(task);
    final storagePath = '$prefix/$path/$filename';

    final metadata = SettableMetadata(contentType: mimeType);

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(storagePath);
      UploadTask uploadTask;
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

  Future<void> _onGetDynamicSchema(GetDynamicSchemaTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(taskStatus: TaskStatus.uninitialized));
    final schema = await getDynamicJson(state.stage.id, state.id, event.response);
    // print(schema);
    emit(state.copyWith(schema: schema, taskStatus: TaskStatus.initialized));
  }

  void _onGenerateIntegratedForm(GenerateIntegratedForm event, Emitter<TaskState> emit) async {
    await gigaTurnipRepository.triggerWebhook(state.id);
    final task = await _getTask(state.id);
    emit(state.copyWith(responses: task.responses, taskStatus: TaskStatus.triggerWebhook));
    emit(state.copyWith(responses: task.responses, taskStatus: TaskStatus.initialized));
  }

  void _onUpdateIntegratedTask(UpdateIntegratedTask event, Emitter<TaskState> emit) {
    _saveTask(event.task);
  }
}
