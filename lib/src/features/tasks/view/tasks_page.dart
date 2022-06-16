import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/cubit/tasks_cubit.dart';
import 'package:gigaturnip/src/features/tasks/view/tasks_view.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: TasksPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksCubit>(
      create: (context) => TasksCubit(
        selectedCampaign: context.read<AppBloc>().state.selectedCampaign!,
        gigaTurnipRepository: context.read<GigaTurnipRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const TasksView(),
    );
  }
}
