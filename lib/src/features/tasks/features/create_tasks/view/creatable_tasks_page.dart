import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/features/app/app.dart';
import 'package:gigaturnip/src/features/tasks/features/create_tasks/view/index.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';
import 'package:gigaturnip/src/features/tasks/features/create_tasks/cubit/index.dart';

class CreateTasksPage extends StatelessWidget {
  const CreateTasksPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CreateTasksPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTasksCubit>(
      create: (context) => CreateTasksCubit(
        selectedCampaign: context.read<AppBloc>().state.selectedCampaign!,
        gigaTurnipRepository: context.read<GigaTurnipRepository>(),
      ),
      child: const CreateTasksView(),
    );
  }
}
