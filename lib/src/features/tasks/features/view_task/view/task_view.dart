import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/bloc/task_bloc.dart';
import 'package:gigaturnip/src/utilities/constants/urls.dart';
import 'package:gigaturnip/src/widgets/richtext_webview/richtext_webview.dart';
import 'package:uniturnip/json_schema_ui.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TaskBloc taskBloc;
  late UIModel formController;

  @override
  void initState() {
    taskBloc = context.read<TaskBloc>();
    taskBloc.add(InitializeTaskEvent());
    formController = UIModel(
      data: taskBloc.state.responses ?? {},
      disabled: taskBloc.state.complete,
      onUpdate: ({required MapPath path, required Map<String, dynamic> data}) {
        taskBloc.add(UpdateTaskEvent(data));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    taskBloc.add(ExitTaskEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taskBloc.state.name),
        leading: BackButton(
          onPressed: () {
            context.read<AppBloc>().add(const AppSelectedTaskChanged(null));
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          formController.data = state.responses ?? {};
          formController.disabled = state.complete;
          if (state.taskStatus == TaskStatus.redirectToNextTask) {
            if (state.nextTask != null) {
              context.read<AppBloc>().add(AppSelectedTaskChanged(state.nextTask));
              Navigator.pushReplacementNamed(context, taskInstanceRoute);
            }
          } else if (state.taskStatus == TaskStatus.redirectToTasksList) {
            Navigator.pop(context, true);
          }
          // TODO: implement error handling
        },
        buildWhen: (previousState, currentState) {
          return (previousState.previousTasks != currentState.previousTasks) || (previousState.complete != currentState.complete);
        },
        builder: (context, state) {
          return ListView(
            children: [
              RichTextWebview(
                text: state.stage.richText ?? '',
                initialUrl: richTextWebviewUrl,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    for (var task in state.previousTasks)
                      JSONSchemaUI(
                        schema: task.schema!,
                        ui: task.uiSchema!,
                        formController: UIModel(disabled: true, data: task.responses ?? {}),
                        hideSubmitButton: true,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: JSONSchemaUI(
                  schema: state.schema!,
                  ui: state.uiSchema!,
                  formController: formController,
                  onSubmit: ({required Map<String, dynamic> data}) {
                    taskBloc.add(SubmitTaskEvent(data));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
