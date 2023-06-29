import 'dart:isolate';
import 'dart:ui';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/utilities/download_service.dart';
import 'package:gigaturnip/src/utilities/functions.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';
import '../widgets/task_divider.dart';

class TaskDetailView extends StatefulWidget {
  final int campaignId;

  const TaskDetailView(this.campaignId, {Key? key}) : super(key: key);

  @override
  State<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<TaskDetailView> {
  final _pageStorageKey = const PageStorageKey('pageKey');
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    if (!kIsWeb) {
      IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {
        // String id = data[0];
        // DownloadTaskStatus status = data[1];
        // int progress = data[2];
        setState(() {});
      });

      FlutterDownloader.registerCallback(downloadCallback);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      IsolateNameServer.removePortNameMapping('downloader_send_port');
    }
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void redirect(BuildContext context, int? nextTaskId) {
    if (nextTaskId != null) {
      context.goNamed(
        TaskDetailRoute.name,
        params: {
          'tid': '$nextTaskId',
          'cid': '${widget.campaignId}',
        },
      );
    } else {
      if (context.canPop()) {
        context.pop(true);
      } else {
        context.goNamed(
          TaskRoute.name,
          params: {
            'cid': '${widget.campaignId}',
          },
        );
      }
    }
  }

  void openWebView(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    final state = bloc.state as TaskInitialized;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebView(
          html: state.data.stage.richText,
          onCloseCallback: () {
            bloc.add(CloseTaskInfo());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final inputDecoration = InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: colorScheme.isLight ? Colors.black : colorScheme.neutral60,
        ),
      ),
    );
    final lightTheme = Theme.of(context).copyWith(inputDecorationTheme: inputDecoration);
    final darkTheme = Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.apply(
            displayColor: Colors.white,
            bodyColor: Colors.white,
          ),
      inputDecorationTheme: inputDecoration,
    );

    return Theme(
      data: colorScheme.isLight ? lightTheme : darkTheme,
      child: BlocConsumer<TaskBloc, TaskState>(listener: (context, state) {
        if (state is TaskSubmitted) {
          redirect(context, state.nextTaskId);
        }
        if (state is TaskClosed) {
          redirect(context, null);
        }
        if (state is TaskInfoOpened) {
          openWebView(context);
        }
      }, builder: (context, state) {
        if (state is TaskFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskFetchingError) {
          return Center(child: Text(state.error));
        }
        if (state is TaskInitialized) {
          return DefaultAppBar(
            title: Text(
              state.data.name,
              overflow: TextOverflow.ellipsis,
            ),
            automaticallyImplyLeading: false,
            leading: [
              BackButton(
                onPressed: () => redirect(context, null),
              )
            ],
            actions: [
              IconButton(
                onPressed: () {
                  context.read<TaskBloc>().add(OpenTaskInfo());
                },
                icon: const Icon(Icons.text_snippet),
              )
            ],
            child: SingleChildScrollView(
              key: _pageStorageKey,
              child: Container(
                decoration: context.isSmall || context.isMedium
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: Shadows.elevation3,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(
                  vertical: context.isSmall || context.isMedium ? 0 : 40,
                  horizontal: context.isSmall || context.isMedium
                      ? 0
                      : MediaQuery.of(context).size.width / 5,
                ),
                child: Column(
                  children: [
                    for (final task in state.previousTasks)
                      _PreviousTask(task: task, pageStorageKey: _pageStorageKey),
                    if (state.previousTasks.isNotEmpty)
                      TaskDivider(label: context.loc.form_divider),
                    _CurrentTask(task: state.data, pageStorageKey: _pageStorageKey),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}

class _CurrentTask extends StatelessWidget {
  final TaskDetail task;
  final PageStorageKey pageStorageKey;

  const _CurrentTask({
    Key? key,
    required this.task,
    required this.pageStorageKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlutterJsonSchemaForm(
        schema: task.schema ?? {},
        uiSchema: task.uiSchema,
        formData: task.responses,
        disabled: task.complete,
        pageStorageKey: pageStorageKey,
        storage: generateStorageReference(task, context.read<AuthenticationRepository>().user),
        onChange: (formData, path) => context.read<TaskBloc>().add(UpdateTask(formData)),
        onSubmit: (formData) => context.read<TaskBloc>().add(SubmitTask(formData)),
        onWebhookTrigger: () => context.read<TaskBloc>().add(TriggerWebhook()),
        onDownloadFile: (url) => DownloadService().download(url: url),
        submitButtonText: Text(context.loc.form_submit_button),
      ),
    );
  }
}

class _PreviousTask extends StatelessWidget {
  final TaskDetail task;
  final PageStorageKey pageStorageKey;

  const _PreviousTask({
    Key? key,
    required this.task,
    required this.pageStorageKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TaskDivider(label: task.name),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlutterJsonSchemaForm(
            schema: task.schema ?? {},
            uiSchema: task.uiSchema,
            formData: task.responses,
            disabled: true,
            pageStorageKey: pageStorageKey,
            storage: generateStorageReference(task, context.read<AuthenticationRepository>().user),
            onDownloadFile: (url) => DownloadService().download(url: url),
          ),
        ),
      ],
    );
  }
}
