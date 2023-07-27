import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
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
import 'package:gigaturnip_api/gigaturnip_api.dart' show GigaTurnipApiClient;
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';

class AvailableTaskPage extends StatelessWidget {
  final int campaignId;
  final int stageId;

  const AvailableTaskPage({Key? key, required this.campaignId, required this.stageId})
      : super(key: key);

  void redirectToTask(BuildContext context, Task item) async {
    final result = await context.pushNamed<bool>(
      TaskDetailRoute.name,
      pathParameters: {
        "cid": "$campaignId",
        "tid": "${item.id}",
      },
    );
    if (context.mounted && (result ?? false)) {
      context.read<AvailableTaskCubit>().refetch();
    }
  }

  void redirectToTaskMenu(BuildContext context) {
    context.goNamed(
      TaskRoute.name,
      pathParameters: {"cid": "$campaignId"},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return DefaultAppBar(
      automaticallyImplyLeading: false,
      leading: [BackButton(onPressed: () => redirectToTaskMenu(context))],
      title: Text(
        context.loc.task_available,
        style: TextStyle(color: theme.isLight ? theme.neutral30 : theme.neutral90),
      ),
      child: BlocProvider(
        create: (context) => AvailableTaskCubit(
          AvailableTaskRepository(
            gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
            campaignId: campaignId,
            stageId: stageId,
          ),
        )..initialize(),
        child: BlocListener<AvailableTaskCubit, RemoteDataState<Task>>(
          listener: (context, state) {
            if (state is AvailableTaskRequestAssignmentSuccess) {
              redirectToTask(context, state.task);
            }
          },
          child: RefreshIndicator(
            onRefresh: () async => context.read<AvailableTaskCubit>().refetch(),
            child: CustomScrollView(
              slivers: [
                SliverListViewWithPagination<Task, AvailableTaskCubit>(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index, item) {
                    return CardWithTitle(
                      chips: [
                        CardChip(item.id.toString()),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AvailableTaskCubit>().requestTaskAssignment(item);
                          },
                          child: Text(context.loc.opentosee),
                        ),
                      ],
                      title: item.name,
                      bottom: TaskPreview(item),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskPreview extends StatefulWidget {
  final Task task;

  const TaskPreview(this.task, {super.key});

  @override
  State createState() => TaskPreviewState();
}

class TaskPreviewState extends State<TaskPreview> {
  Completer<List<TaskDetail>> _responseCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: CardDate(date: widget.task.createdAt?.toLocal()),
      onExpansionChanged: (bool isExpanding) {
        if (!_responseCompleter.isCompleted) {
          final api = context.read<GigaTurnipApiClient>();
          _responseCompleter.complete(
            TaskDetailRepository(gigaTurnipApiClient: api).fetchPreviousTaskData(widget.task.id),
          );
        }
      },
      children: <Widget>[
        FutureBuilder(
          future: _responseCompleter.future,
          builder: (BuildContext context, AsyncSnapshot<List<TaskDetail>> response) {
            final data = response.data;
            if (response.connectionState != ConnectionState.done) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (data == null) {
                return const SizedBox.shrink();
              }
              List<Widget> tasks = [];
              for (var item in data) {
                tasks.add(FlutterJsonSchemaForm(
                  schema: item.schema ?? {},
                  uiSchema: item.uiSchema,
                  formData: item.responses,
                  disabled: true,
                  storage:
                      generateStorageReference(item, context.read<AuthenticationRepository>().user),
                  addFileText: [context.loc.select_file, context.loc.to_upload],
                  onDownloadFile: (url, filename, bytes) =>
                      DownloadService().download(url: url, filename: filename, bytes: bytes),
                ));
              }
              if (data.isNotEmpty) {
                tasks.add(const Divider(color: Colors.black, height: 36, thickness: 2));
              }
              tasks.add(FlutterJsonSchemaForm(
                schema: widget.task.cardJsonSchema ?? {},
                uiSchema: widget.task.cardUiSchema,
                formData: widget.task.responses,
                disabled: true,
                storage: generateStorageReference(
                    widget.task, context.read<AuthenticationRepository>().user),
                addFileText: [context.loc.select_file, context.loc.to_upload],
                onDownloadFile: (url, filename, bytes) =>
                    DownloadService().download(url: url, filename: filename, bytes: bytes),
              ));
              return Column(children: tasks);
            }
          },
        )
      ],
    );
  }
}
