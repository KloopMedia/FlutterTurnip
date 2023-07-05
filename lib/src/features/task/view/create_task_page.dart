import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class CreateTaskPage extends StatefulWidget {
  final int taskId;

  const CreateTaskPage({Key? key, required this.taskId}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  Future<void> createTask() async {
    final campaignId = GoRouterState.of(context).pathParameters['cid'];
    if (campaignId != null) {
      try {
        final api = context.read<GigaTurnipApiClient>();
        final repository = CreatableTaskRepository(
          gigaTurnipApiClient: api,
          campaignId: int.parse(campaignId),
          isProactive: false,
        );
        final newTaskId = await repository.createTask(widget.taskId);
        if (!mounted) return;
        context.goNamed(TaskDetailRoute.name, pathParameters: {'cid': campaignId, 'tid': '$newTaskId'});
      } catch (e) {
        print(e);
        context.goNamed(TaskRoute.name, pathParameters: {'cid': campaignId});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
            onPressed: () {
              createTask();
            },
            child: const Text(
              'Суу көйгөйү жөнүндө билдирүү / Рассказать о проблеме воды',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
