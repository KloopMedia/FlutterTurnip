import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/src/features/task_detail/widgets/task_divider.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../bloc/bloc.dart';
import '../../../utilities/download_service.dart';
import '../../../utilities/functions.dart';
import '../bloc/bloc.dart';

class PreviousTask extends StatelessWidget {
  final TaskDetail task;
  final PageStorageKey pageStorageKey;

  const PreviousTask({
    super.key,
    required this.task,
    required this.pageStorageKey,
  });

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
              var status = await DownloadService().download(
                url: url,
                filename: filename,
                bytes: bytes,
              );
              taskBloc.add(DownloadFile(status!));
              return status;
            },
          ),
        ),
      ],
    );
  }
}
