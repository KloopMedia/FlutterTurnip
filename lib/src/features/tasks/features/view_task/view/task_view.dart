import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/bloc/task_bloc.dart';
import 'package:gigaturnip/src/utilities/constants/urls.dart';
import 'package:gigaturnip/src/widgets/richtext_webview/richtext_webview.dart';
import 'package:go_router/go_router.dart';
import 'package:uniturnip/json_schema_ui.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TaskBloc taskBloc;
  late UIModel formController;
  late String richText;

  @override
  void initState() {
    taskBloc = context.read<TaskBloc>();
    taskBloc.add(InitializeTaskEvent());
    formController = UIModel(
      data: taskBloc.state.responses ?? {},
      disabled: taskBloc.state.complete,
      onUpdate: ({required MapPath path, required Map<String, dynamic> data}) {
        if (taskBloc.state.stage.dynamicJsons.isNotEmpty) {
          taskBloc.add(GetDynamicSchemaTaskEvent(data));
          print('>>> taskBloc.state.stage.dynamicJsons: ${taskBloc.state.stage.dynamicJsons}');//[{main: marital_status, count: 1, foreign: [salary]}]
        }
        taskBloc.add(UpdateTaskEvent(data));
        print('>>> onUpdate data: $data');//{age: 11, date: 2022-08-05, name: ап, time: t_15_30, region: chuy_region, salary: больше сомов 30 000 в месяц, comments: ирll, employed: Постоянная работа, nationality: ро, phone_number: 556, actual_address: рол, marital_status: Не женат_Не замужем, whatsapp_number: 566, meeting_with_whom: ombudsman, benefits_or_pension: Да, description_of_problem: ммр}
      },
      saveFile: (rawFile, path, type, {private = false}) {
        return context.read<TaskBloc>().uploadFile(
              file: rawFile,
              path: path,
              type: type,
              private: private,
            );
      },
      getFile: (path) {
        return context.read<TaskBloc>().getFile(path);
      },
      saveAudioRecord: (file, private) async {
        final task = await context.read<TaskBloc>().uploadFile(
              file: file,
              type: FileType.any,
              private: private,
              path: null,
            );
        return task!.snapshot.ref.fullPath;
      },
      // getDynamicJson: (/*int id, Map data*/) async {
      //   return context.read<TaskBloc>().getDynamicJson(taskBloc.state.id, taskBloc.state.responses);
      // },
    );
    richText = taskBloc.state.stage.richText ?? '';
    super.initState();
  }

  @override
  void dispose() {
    taskBloc.add(ExitTaskEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var location = Router.of(context).routeInformationProvider?.value.location;
    var queryStartIndex = location?.indexOf('?') ?? -1;
    String query;
    if (queryStartIndex > 0) {
      query = location?.substring(queryStartIndex) ?? '';
    } else {
      query = '';
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.read<TaskBloc>().state.name,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: Theme.of(context).textTheme.headlineMedium),
        leading: BackButton(
          onPressed: () {
            context.read<AppBloc>().add(const AppSelectedTaskChanged(null));
            context.read<TaskBloc>().add(ExitTaskEvent());
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
              final selectedCampaign = context.read<AppBloc>().state.selectedCampaign!;
              context.go('/campaign/${selectedCampaign.id}/tasks/${state.nextTask!.id}$query');
            }
          } else if (state.taskStatus == TaskStatus.redirectToTasksList) {
            context.pop();
          }
          // TODO: implement error handling
        },
        buildWhen: (previousState, currentState) {
          return (previousState.previousTasks != currentState.previousTasks) ||
              (previousState.complete != currentState.complete);
        },
        builder: (context, state) {
          return ListView(
            children: [
              if (richText.isNotEmpty)
                RichTextWebview(
                  text: richText,
                  initialUrl: richTextWebviewUrl,
                ),
              if (state.previousTasks.isNotEmpty)
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
