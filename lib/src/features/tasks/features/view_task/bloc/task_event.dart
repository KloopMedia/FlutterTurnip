part of 'task_bloc.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class InitializeTaskEvent extends TaskEvent {}

class UpdateTaskEvent extends TaskEvent {
  final Map<String, dynamic> formData;

  UpdateTaskEvent(this.formData);
}

class SubmitTaskEvent extends TaskEvent {
  final Map<String, dynamic> formData;

  SubmitTaskEvent(this.formData);
}

class ExitTaskEvent extends TaskEvent {}

class UploadFilesTaskEvent extends TaskEvent {
  final List<String> paths;

  UploadFilesTaskEvent(this.paths);
}

class GetDynamicSchemaTaskEvent extends TaskEvent {
  final Map<String, dynamic> response;

  GetDynamicSchemaTaskEvent(this.response);
}

class GenerateIntegratedForm extends TaskEvent {
  const GenerateIntegratedForm();
}

class OpenWebView extends TaskEvent {
  const OpenWebView();
}

class CloseWebView extends TaskEvent {
  const CloseWebView();
}

class UpdateIntegratedTask extends TaskEvent {
  final Task task;

  UpdateIntegratedTask(this.task);
}

class TriggerWebhook extends TaskEvent {}
