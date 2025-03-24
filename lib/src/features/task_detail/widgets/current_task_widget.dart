import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../bloc/bloc.dart';
import '../../../utilities/download_service.dart';
import '../../../utilities/functions.dart';
import '../bloc/bloc.dart';

class CurrentTask extends StatelessWidget {
  final TaskDetail task;
  final PageStorageKey pageStorageKey;
  final ScrollController scrollController;
  final bool showAnswers;
  final void Function()? redirect;

  const CurrentTask({
    super.key,
    required this.task,
    required this.pageStorageKey,
    required this.scrollController,
    required this.redirect,
    required this.showAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final taskBloc = context.read<TaskBloc>();
    final theme = Theme.of(context).colorScheme;

    return SizedBox(
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
    );
  }
}
