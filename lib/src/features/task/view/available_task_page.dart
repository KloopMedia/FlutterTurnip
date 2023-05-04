import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
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

  void redirectToTask(BuildContext context, Task item) {
    context.pushNamed(
      TaskDetailRoute.name,
      params: {
        "cid": "$campaignId",
        "tid": "${item.id}",
      },
    );
  }

  void redirectToTaskMenu(BuildContext context) {
    context.goNamed(
      TaskRoute.name,
      params: {"cid": "$campaignId"},
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      automaticallyImplyLeading: false,
      leading: [BackButton(onPressed: () => redirectToTaskMenu(context))],
      title: const Text('Доступные задания'),
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
          child: CustomScrollView(
            slivers: [
              SliverListViewWithPagination<Task, AvailableTaskCubit>(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index, item) {
                  return CardWithTitle(
                    chips: [
                      const CardChip('Placeholder'),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AvailableTaskCubit>().requestTaskAssignment(item);
                        },
                        child: const Text('Открыть'),
                      ),
                    ],
                    title: item.name,
                    bottom: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: CardDate(date: item.createdAt),
                      children: [
                        FlutterJsonSchemaForm(
                          schema: item.cardJsonSchema ?? {},
                          uiSchema: item.cardUiSchema,
                          formData: item.responses,
                          disabled: true,
                          storage: generateStorageReference(
                              item, context.read<AuthenticationRepository>().user),
                          onDownloadFile: (url) => DownloadService().download(url: url),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
