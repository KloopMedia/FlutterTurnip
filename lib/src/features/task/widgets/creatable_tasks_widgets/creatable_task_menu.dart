import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/router/routes/routes.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:go_router/go_router.dart';

class CreatableTaskMenu extends StatelessWidget {
  final int campaignId;

  const CreatableTaskMenu({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    void redirectToTask(BuildContext context, int id) {
      context.goNamed(
        TaskDetailRoute.name,
        pathParameters: {
          "cid": "$campaignId",
          "tid": "$id",
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BlocConsumer<ProactiveTasks, RemoteDataState<TaskStage>>(
            listener: (context, state) {
              if (state is TaskCreated) {
                redirectToTask(context, state.createdTaskId);
              }
            },
            builder: (context, state) {
              if (state is RemoteDataLoaded<TaskStage>) {
                final data = state.data;
                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(262, 41),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            context.read<ProactiveTasks>().createTask(item);
                          },
                          child: Text(item.name, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    );
                  },
                  itemCount: data.length,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 17, bottom: 2),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: theme.primary,
              onPressed: () {
                context.pop();
              },
              child: const Icon(Icons.close),
            ),
          )
        ],
      ),
    );
  }
}
