import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

import '../bloc/bloc.dart';
import '../widgets/task_divider.dart';


class TaskDetailView extends StatelessWidget {
  const TaskDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskFetchingError) {
          return Text(state.error);
        }
        if (state is TaskLoaded) {
          return Column(
            children: [
              TaskDivider(label: context.loc.form_divider),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlutterJsonSchemaForm(
                  schema: state.data.schema ?? {},
                  uiSchema: state.data.uiSchema,
                  formData: state.data.responses,
                  disabled: state.data.complete,
                  onChange: (formData, path) => context.read<TaskBloc>().add(UpdateTask(formData)),
                  onSubmit: (formData) => context.read<TaskBloc>().add(SubmitTask(formData)),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
