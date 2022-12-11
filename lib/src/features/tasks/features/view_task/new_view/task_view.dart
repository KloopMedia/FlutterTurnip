import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/utilities/dialogs/form_validation_snackbar.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:uniturnip/json_schema_ui.dart';

import '../new_task_bloc/task_bloc.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is CommonTask) {
            return CommonTaskView(task: state.task, previousTasks: state.previousTasks);
          }

          if (state is IntegratedTask) {
            return IntegratedTaskView(task: state.task, integratedTasks: state.integratedTasks);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

UIModel createFormController({
  required Task task,
  required TaskBloc taskBloc,
  ChangeCallback? onUpdate,
  UploadFileCallback? onSaveFile,
  GetFileCallback? onGetFile,
  SaveAudioRecordCallback? onSaveAudio,
}) {
  return UIModel(
    data: task.responses ?? {},
    disabled: task.complete,
    onUpdate: onUpdate ??
        ({required MapPath path, required Map<String, dynamic> data}) {
          taskBloc.add(UpdateTaskEvent(formData: data, path: path));
        },
    saveFile: onSaveFile ??
        (rawFile, path, type, {private = false}) {
          return taskBloc.uploadFile(file: rawFile, path: path, type: type, private: private);
        },
    getFile: onGetFile ??
        (path) {
          return taskBloc.getFile(path);
        },
    saveAudioRecord: onSaveAudio ??
        (file, private) async {
          final task = await taskBloc.uploadFile(
            file: file,
            type: FileType.any,
            private: private,
            path: null,
          );
          return task!.snapshot.ref.fullPath;
        },
  );
}

class BaseTask extends StatelessWidget {
  final Task task;

  const BaseTask({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JSONSchemaUI(
      schema: task.schema!,
      ui: task.uiSchema!,
      formController: createFormController(
        task: task,
        taskBloc: context.read<TaskBloc>(),
      ),
      onSubmit: ({required Map<String, dynamic> data}) {
        context.read<TaskBloc>().add(SubmitTaskEvent(data));
      },
      onValidationFailed: () {
        showValidationFailedSnackBar(context: context);
      },
    );
  }
}

class CommonTaskView extends StatelessWidget {
  final Task task;
  final List<Task> previousTasks;

  const CommonTaskView({Key? key, required this.task, required this.previousTasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (previousTasks.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                for (var task in previousTasks)
                  JSONSchemaUI(
                    schema: task.schema!,
                    ui: task.uiSchema!,
                    formController: UIModel(disabled: true, data: task.responses ?? {}),
                    hideSubmitButton: true,
                  ),
              ],
            ),
          ),
        BaseTask(task: task),
      ],
    );
  }
}

class IntegratedTaskView extends StatelessWidget {
  final Task task;
  final List<Task> integratedTasks;

  const IntegratedTaskView({Key? key, required this.task, required this.integratedTasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (integratedTasks.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                for (var task in integratedTasks)
                  JSONSchemaUI(
                    schema: task.schema!,
                    ui: task.uiSchema!,
                    formController: createFormController(
                      task: task,
                      taskBloc: context.read<TaskBloc>(),
                    ),
                    hideSubmitButton: true,
                  ),
              ],
            ),
          ),
        ElevatedButton(onPressed: () {}, child: const Text('Generate Form')),
        BaseTask(task: task),
      ],
    );
  }
}
