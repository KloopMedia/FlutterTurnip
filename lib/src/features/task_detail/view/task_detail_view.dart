import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/utilities/download_service.dart';
import 'package:gigaturnip/src/utilities/functions.dart';
import 'package:gigaturnip/src/widgets/app_bar/default_app_bar.dart';
import 'package:gigaturnip/src/widgets/widgets.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/button/dialog/dialog_button_outlined.dart';
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
  final ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  void redirect(BuildContext context, int? nextTaskId) {
    if (nextTaskId != null) {
      context.goNamed(
        TaskDetailRoute.name,
        pathParameters: {
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
          pathParameters: {
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
          allowOpenPrevious: state.data.stage.allowGoBack,
          onOpenPreviousTask: () => bloc.add(GoBackToPreviousTask()),
          onCloseCallback: () => bloc.add(CloseTask()),
          onSubmitCallback: () => bloc.add(CloseTaskInfo()),
        ),
      ),
    );
  }

  void openOfflineDialog(BuildContext context, String phoneNumber, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return OfflinePhoneMessageDialog(
          phoneNumber: phoneNumber,
          message: message,
        );
      },
    );
  }

  void showFileStatus(BuildContext context, String status) {
    showDialog(
      context: context,
      builder: (context) => FormDialog(
        content: status,
        buttonText: context.loc.ok,
      ),
    );
  }

  void showFormError(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => FormDialog(
        title: context.loc.form_error,
        content: error,
        buttonText: context.loc.ok,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskBloc>();
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
      child: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) async {
          if (state is TaskSubmitted) {
            redirect(context, state.nextTaskId);
          }
          if (state is NotificationOpened) {
            showDialog(
              context: context,
              builder: (context) => FormDialog(
                title: context.loc.new_notification,
                content: state.text,
                buttonText: context.loc.got_it,
                onPressed: () {
                  bloc.add(CloseNotification(state.previousTasks, state.data, state.nextTaskId));
                },
              ),
            );
          }
          if (state is TaskClosed) {
            redirect(context, null);
          }
          if (state is TaskInfoOpened) {
            openWebView(context);
          }
          if (state is TaskReleased) {
            redirect(context, null);
          }
          if (state is GoBackToPreviousTaskState) {
            redirect(context, state.previousTaskId);
          }
          if (state is TaskReturned) {
            showDialog(
              context: context,
              builder: (context) {
                return const TaskReturnedDialog();
              },
            );
          }
          if (state is FileDownloaded) {
            if (!kIsWeb) showFileStatus(context, state.message);
          }
          if (state is TaskErrorState) {
            showFormError(context, state.error);
          }
          if (state is RedirectToSms) {
            final phoneNumber = state.phoneNumber;
            final payload = {'stage': state.data.stage, 'responses': state.data.responses};
            final message = jsonEncode(payload);
            try {
              final uri = Uri.parse('sms:$phoneNumber?body=$message');
              await launchUrl(uri);
            } catch (e) {
              openOfflineDialog(context, phoneNumber ?? '', message);
            }
          }
        },
        child: DefaultAppBar(
          title: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return Text(
                state is TaskInitialized ? state.data.name : '',
                overflow: TextOverflow.ellipsis,
              );
            },
          ),
          automaticallyImplyLeading: false,
          leading: [
            BackButton(
              onPressed: () => redirect(context, null),
            )
          ],
          actions: [
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskInitialized && state.data.stage.allowRelease) {
                  return TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return ReleaseTaskDialog(
                            onConfirm: () {
                              context.read<TaskBloc>().add(ReleaseTask());
                            },
                          );
                        },
                      );
                    },
                    child: Text(context.loc.release_task_button),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
          child: RefreshIndicator(
            onRefresh: () async => context.read<TaskBloc>().add(RefetchTask()),
            child: SingleChildScrollView(
              controller: scrollController,
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
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is TaskInitialized) {
                      return Column(
                        children: [
                          if (state.data.stage.richText?.isNotEmpty ?? false)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10),
                              child: DialogButtonOutlined(
                                  child: Text(context.loc.open_richtext),
                                  onPressed: () => context.read<TaskBloc>().add(OpenTaskInfo())),
                            ),
                          for (final task in state.previousTasks)
                            _PreviousTask(task: task, pageStorageKey: _pageStorageKey),
                          if (state.previousTasks.isNotEmpty)
                            const Divider(color: Colors.black, height: 36, thickness: 2),
                          _CurrentTask(
                            task: state.data,
                            pageStorageKey: _pageStorageKey,
                            scrollController: scrollController,
                            showAnswers: state is ShowAnswers,
                            redirect: state is ShowAnswers
                                ? () => redirect(context, state.nextTaskId)
                                : null,
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CurrentTask extends StatelessWidget {
  final TaskDetail task;
  final PageStorageKey pageStorageKey;
  final ScrollController scrollController;
  final bool showAnswers;
  final void Function()? redirect;

  const _CurrentTask({
    Key? key,
    required this.task,
    required this.pageStorageKey,
    required this.scrollController,
    required this.redirect,
    required this.showAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskBloc = context.read<TaskBloc>();
    final theme = Theme.of(context).colorScheme;

    return SafeArea(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlutterJsonSchemaForm(
            schema: task.schema ?? {},
            uiSchema: task.uiSchema,
            formData: task.responses,
            disabled: task.complete,
            pageStorageKey: pageStorageKey,
            storage: generateStorageReference(task, context.read<AuthenticationRepository>().user),
            onChange: (formData, path) => context.read<TaskBloc>().add(UpdateTask(formData)),
            onSubmit: (formData) {
              context.read<TaskBloc>().add(SubmitTask(formData));
              scrollController.jumpTo(0);
            },
            onWebhookTrigger: () => context.read<TaskBloc>().add(TriggerWebhook()),
            onDownloadFile: (url, filename, bytes) async {
              var status =
                  await DownloadService().download(url: url, filename: filename, bytes: bytes);
              taskBloc.add(DownloadFile(status!));
              return status;
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            locale: context.read<LocalizationBloc>().state.locale,
            correctFormData: task.stage.quizAnswers,
            showCorrectFields: task.complete,
            extraButtons: [
              if (showAnswers)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: theme.primary,
                    foregroundColor: theme.isLight ? Colors.white : Colors.black,
                  ),
                  onPressed: redirect,
                  child: Text(context.loc.form_submit_button),
                ),
              if (task.stage.allowGoBack)
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => taskBloc.add(GoBackToPreviousTask()),
                  child: Text(context.loc.go_back_to_previous_task),
                )
            ],
          ),
        ),
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
    final taskBloc = context.read<TaskBloc>();

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
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            locale: context.read<LocalizationBloc>().state.locale,
            onDownloadFile: (url, filename, bytes) async {
              var status =
                  await DownloadService().download(url: url, filename: filename, bytes: bytes);
              taskBloc.add(DownloadFile(status!));
              return status;
            },
          ),
        ),
      ],
    );
  }
}
