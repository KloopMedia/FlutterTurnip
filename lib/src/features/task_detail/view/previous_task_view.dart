import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class PreviousTaskView extends StatelessWidget {
  const PreviousTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousTaskBloc, PreviousTaskState>(
      builder: (context, state) {
        if (state is PreviousTaskFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PreviousTaskFetchingError) {
          return Text(state.error);
        }
        if (state is PreviousTaskInitialized) {
          return ListView.builder(
            itemCount: state.data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final task = state.data[index];
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
                    ),
                  ),
                ],
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
