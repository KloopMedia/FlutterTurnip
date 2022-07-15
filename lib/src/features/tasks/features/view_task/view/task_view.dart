import 'dart:async';
import 'dart:convert' show utf8, base64;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/view_task/bloc/task_bloc.dart';
import 'package:uniturnip/json_schema_ui.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TaskBloc taskBloc;
  late UIModel formController;
  late WebViewController _webViewController;

  @override
  void initState() {
    taskBloc = context.read<TaskBloc>();
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
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          formController.data = state.responses!;
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
        child: Column(
          children: [
            Expanded(
              child: WebView(
                debuggingEnabled: true,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'http://localhost:3000/',
                onWebViewCreated: (WebViewController webViewController) {
                  setState(() {
                    _webViewController = webViewController;
                  });
                },
                onPageFinished: (str) async {
                  final text = context.read<TaskBloc>().state.stage.richText ?? '';
                  final encodedText = base64.encode(utf8.encode(text));
                  Future.delayed(const Duration(milliseconds: 10), () {
                    _webViewController.runJavascript("""
                  (function() { window.dispatchEvent(new CustomEvent('flutter_rich_text_event', {detail: "$encodedText"})); })();
                    """);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: JSONSchemaUI(
                schema: taskBloc.state.schema!,
                ui: taskBloc.state.uiSchema!,
                formController: formController,
                onSubmit: ({required Map<String, dynamic> data}) {
                  taskBloc.add(SubmitTaskEvent(data));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
