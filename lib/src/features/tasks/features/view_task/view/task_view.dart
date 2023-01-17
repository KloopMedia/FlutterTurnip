import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/list_tasks/cubit/important_notifications_cubit.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/bloc/task_bloc.dart';
import 'package:gigaturnip/src/utilities/dialogs/form_validation_snackbar.dart';
import 'package:gigaturnip/src/widgets/richtext/richtext_view.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import '../../../../notifications/view/notification_view.dart';
import '../../../../notifications/view/notifications_sliver_list_view.dart';
// import 'package:uniturnip/json_schema_ui.dart';

class TaskView extends StatefulWidget {
  final bool simpleViewMode;
  const TaskView({Key? key, required this.simpleViewMode}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TaskBloc taskBloc;
  //late UIModel formController;
  late String richText;
  bool isRichTextViewed = true;

  @override
  void initState() {
    taskBloc = context.read<TaskBloc>();
    taskBloc.add(InitializeTaskEvent());
    // formController = UIModel(
    //   data: taskBloc.state.responses ?? {},
    //   disabled: taskBloc.state.complete,
    //   onUpdate: ({required MapPath path, required Map<String, dynamic> data}) {
    //     taskBloc.add(UpdateTaskEvent(data));
    //     final dynamicJsonMetadata = taskBloc.state.stage.dynamicJsonsTarget;
    //     if (dynamicJsonMetadata != null && dynamicJsonMetadata.isNotEmpty) {
    //       if (dynamicJsonMetadata.first['main'] == path.last ||
    //           (dynamicJsonMetadata.first['foreign'] as List).contains(path.last)) {
    //         taskBloc.add(GetDynamicSchemaTaskEvent(data));
    //       }
    //     }
    //   },
    //   saveFile: (rawFile, path, type, {private = false}) {
    //     return context.read<TaskBloc>().uploadFile(
    //           file: rawFile,
    //           path: path,
    //           type: type,
    //           private: private,
    //           task: taskBloc.state,
    //         );
    //   },
    //   getFile: (path) {
    //     return context.read<TaskBloc>().getFile(path);
    //   },
    //   saveAudioRecord: (file, private) async {
    //     final task = await context.read<TaskBloc>().uploadFile(
    //           file: file,
    //           type: FileType.any,
    //           private: private,
    //           path: null,
    //           task: taskBloc.state,
    //         );
    //     return task!.snapshot.ref.fullPath;
    //   },
    // );
    richText = taskBloc.state.stage.richText ?? '';
    if (isRichTextViewed && richText.isNotEmpty) {
      _showRichText();
    }
    super.initState();
  }

  @override
  void dispose() {
    taskBloc.add(ExitTaskEvent());
    super.dispose();
  }

  void onWebviewClose() {
    if (!taskBloc.state.complete) {
      taskBloc.add(SubmitTaskEvent({}));
    }
  }

  void _showRichText() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RichTextView(
            htmlText: richText,
            onCloseCallback: (taskBloc.state.schema?.isEmpty ?? true) ? onWebviewClose : null,
          ),
        ),
      );
      setState(() {
        isRichTextViewed = false;
      });
    });
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
      appBar: (widget.simpleViewMode)
          ? AppBar(
            title: Text(
              context.read<TaskBloc>().state.name,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(height: 0.9, color: Theme.of(context).colorScheme.primary)),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                context.read<AppBloc>().add(const AppSelectedTaskChanged(null));
                context.read<TaskBloc>().add(ExitTaskEvent());
              },
            ),
          )
          : AppBar(
            title: Text(
                context.read<TaskBloc>().state.name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(height: 0.9)),
            centerTitle: true,
            leading: BackButton(
              onPressed: () {
                context.read<AppBloc>().add(const AppSelectedTaskChanged(null));
                context.read<TaskBloc>().add(ExitTaskEvent());
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  _showRichText();
                },
                icon: const Icon(Icons.article),
                iconSize: 40.0,
              )
            ],
          ),
      body: BlocConsumer<TaskBloc, TaskState>(
            listener: (context, state) {
              // formController.data = state.responses ?? {};
              // formController.disabled = state.complete;
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
              var hasPreviousTasksChange = previousState.previousTasks != currentState.previousTasks;
              var hasCompleteChange = previousState.complete != currentState.complete;
              var hasSchemaChange =
              !(const DeepCollectionEquality().equals(previousState.schema, currentState.schema));
              var isWebhookTriggered = currentState.taskStatus == TaskStatus.triggerWebhook;

              var shouldRebuild =
                  hasPreviousTasksChange || hasCompleteChange || hasSchemaChange || isWebhookTriggered;
              return shouldRebuild;
            },
            builder: (context, state) {
              return ListView(
                children: [
                  if (state.isIntegrated)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          for (var task in state.integratedTasks)
                            ExpansionCard(
                              task: task,
                              // child: JSONSchemaUI(
                              //   schema: task.schema!,
                              //   ui: task.uiSchema!,
                              //   hideSubmitButton: true,
                              //   formController: UIModel(
                              //     data: task.responses ?? {},
                              //     disabled: task.complete,
                              //     onUpdate: ({
                              //       required MapPath path,
                              //       required Map<String, dynamic> data,
                              //     }) {
                              //       final updatedTask = task.copyWith(responses: data);
                              //       taskBloc.add(UpdateIntegratedTask(updatedTask));
                              //     },
                              //     saveFile: (rawFile, path, type, {private = false}) {
                              //       return context.read<TaskBloc>().uploadFile(
                              //             file: rawFile,
                              //             path: path,
                              //             type: type,
                              //             private: private,
                              //             task: task,
                              //           );
                              //     },
                              //     getFile: (path) {
                              //       return context.read<TaskBloc>().getFile(path);
                              //     },
                              //     saveAudioRecord: (file, private) async {
                              //       final uploadTask = await context.read<TaskBloc>().uploadFile(
                              //             file: file,
                              //             type: FileType.any,
                              //             private: private,
                              //             path: null,
                              //             task: task,
                              //           );
                              //       return uploadTask!.snapshot.ref.fullPath;
                              //     },
                              //   ),
                              // ),
                              child: FlutterJsonSchemaForm(
                                schema: task.schema!,
                                uiSchema: task.uiSchema,
                                formData: task.responses,
                                disabled: task.complete,
                                storage: taskBloc.storage,
                                onChange: (Map<String, dynamic> data, String path) {
                                  final updatedTask = task.copyWith(responses: data);
                                  taskBloc.add(UpdateIntegratedTask(updatedTask));
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (state.previousTasks.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          for (var task in state.previousTasks)
                          // JSONSchemaUI(
                          //   schema: task.schema!,
                          //   ui: task.uiSchema!,
                          //   formController: UIModel(disabled: true, data: task.responses ?? {}),
                          //   hideSubmitButton: true,
                          // ),
                            FlutterJsonSchemaForm(
                              schema: task.schema!,
                              uiSchema: task.uiSchema,
                              formData: task.responses,
                              disabled: true,
                              storage: taskBloc.storage,
                            ),
                        ],
                      ),
                    ),
                  if (state.isIntegrated)
                    ElevatedButton(
                      onPressed: () {
                        context.read<TaskBloc>().add(const GenerateIntegratedForm());
                      },
                      child: const Text('Generate form'),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // child: JSONSchemaUI(
                    //     schema: state.schema!,
                    //     ui: state.uiSchema!,
                    //     formController: formController,
                    //     onSubmit: ({required Map<String, dynamic> data}) {
                    //       taskBloc.add(SubmitTaskEvent(data));
                    //     },
                    //     onValidationFailed: () {
                    //       showValidationFailedSnackBar(context: context);
                    //     }),
                    child: FlutterJsonSchemaForm(
                        schema: state.schema!,
                        uiSchema: state.uiSchema,
                        formData: state.responses ?? {},
                        disabled: state.complete,
                        storage: taskBloc.storage,
                        onChange: (Map<String, dynamic> data, String path) {
                          taskBloc.add(UpdateTaskEvent(data));
                          final dynamicJsonMetadata = taskBloc.state.stage.dynamicJsonsTarget;
                          final pathList = path.split('.');
                          if (dynamicJsonMetadata != null && dynamicJsonMetadata.isNotEmpty) {
                            if (dynamicJsonMetadata.first['main'] == pathList || (dynamicJsonMetadata.first['foreign'] as List).contains(pathList)) {
                              taskBloc.add(GetDynamicSchemaTaskEvent(data));
                            }
                          }
                        },
                        onSubmit: (Map<String, dynamic> data) {
                          taskBloc.add(SubmitTaskEvent(data));
                        },
                        onValidationFailed: () {
                          showValidationFailedSnackBar(context: context);
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        for(var notification in state.notifications)
                          ItemCard(
                            item: notification,
                            onTap: (notification) {
                              final selectedCampaign = context.read<AppBloc>().state.selectedCampaign!;
                              context.go('/campaign/${selectedCampaign.id}/notifications');
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }
}

class ExpansionCard extends StatefulWidget {
  final Task task;
  final Widget child;

  const ExpansionCard({Key? key, required this.task, required this.child}) : super(key: key);

  @override
  State<ExpansionCard> createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.cyan,
      title: Text(
        widget.task.name,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text('#${widget.task.id} ${widget.task.stage.description}'),
      trailing: Icon(_customTileExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
      onExpansionChanged: (bool expanded) {
        setState(() => _customTileExpanded = expanded);
      },
      children: [widget.child],
    );
  }
}
