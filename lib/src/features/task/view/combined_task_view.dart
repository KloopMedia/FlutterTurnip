import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/remote_data_bloc/remote_data_cubit.dart';
import 'package:gigaturnip/src/features/campaign_detail/bloc/campaign_detail_bloc.dart';
import 'package:gigaturnip/src/features/task/bloc/bloc.dart';
import 'package:gigaturnip/src/features/task/widgets/form_card.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart' hide Task;
import 'package:gigaturnip_repository/gigaturnip_repository.dart'
    hide TaskStage;
import 'package:go_router/go_router.dart';
import '../../../helpers/app_drawer.dart';
import '../../../helpers/notification_icon.dart';
import '../../../router/routes/routes.dart';

typedef ItemCallback = void Function(TaskStage item);

class CombinedTasksView extends StatefulWidget {
  final int campaignId;

  const CombinedTasksView({Key? key, required this.campaignId})
      : super(key: key);

  @override
  State<CombinedTasksView> createState() => _CombinedTasksViewState(campaignId);
}

class _CombinedTasksViewState extends State<CombinedTasksView> {
  final campaignId;

  _CombinedTasksViewState(this.campaignId);

  final ScrollController _scrollController = ScrollController();
  final query = 'simple=true';

  // @override
  // initState() {
  //   context.read<TasksCubit>().initializeCombined();
  //   context.read<ImportantNotificationsCubit>().getLastTaskNotifications();
  //   _scrollController = ScrollController();
  //   _scrollController.addListener(() {
  //     var nextPageTrigger = 0.99 * _scrollController.position.maxScrollExtent;
  //
  //     if (_scrollController.position.pixels > nextPageTrigger &&
  //         context.read<TasksCubit>().state.status == TasksStatus.initialized &&
  //         context.read<TasksCubit>().state.hasNextPage) {
  //       context.read<TasksCubit>().getNextPage();
  //     }
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  void onTap(Task task) {
    final selectedCampaign = context.read<CampaignDetailBloc>().campaignId;
    context.go('/campaign/:$selectedCampaign/task/:${task.id}');
  }

  void redirectToTask(BuildContext context, int id) {
    context.goNamed(
      TaskDetailRoute.name,
      params: {
        'cid': '$campaignId',
        'tid': '$id',
      },
    );
  }

  final IconData iconToDo = Icons.today_rounded;
  final IconData iconDone = Icons.assignment_turned_in_outlined;

  @override
  Widget build(BuildContext context) {
    // late final List<TaskStage> items;
    return MultiBlocProvider(
      providers: [
        BlocProvider<AvailableTaskCubit>(
          create: (BuildContext context) => AvailableTaskCubit(
            AvailableTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider<CreatableTaskCubit>(
          create: (BuildContext context) => CreatableTaskCubit(
            CreatableTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          )..initialize(),
        ),
        BlocProvider<OpenTaskCubit>(
          create: (BuildContext context) =>
              RelevantTaskCubit(OpenTaskRepository(
            gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
            campaignId: campaignId,
          ))
                ..initialize(),
        ),
        BlocProvider<ClosedTaskCubit>(
          create: (BuildContext context) =>
              RelevantTaskCubit(ClosedTaskRepository(
            gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
            campaignId: campaignId,
          ))
                ..initialize(),
        ),
      ],
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   automaticallyImplyLeading: false,
          // actions: <Widget>[
            // IconButton(
            //   onPressed: () {
            //     // Navigator.of(context).pushNamed(notificationsRoute);
            //     final selectedCampaign = context.read<CampaignDetailBloc>().campaignId;
            //     context.go('/campaign/$selectedCampaign/notifications?$query');
            //   },
            //   icon: const NotificationIcon(),
            // ),
          // ],
        // ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: MultiBlocListener(
            listeners: [
              BlocListener<AvailableTaskCubit, RemoteDataState>(
                  listener: (context, state) {
                if (state is AvailableTaskRequestAssignmentSuccess) {
                  redirectToTask(context, state.task.id);
                }
              }),
              BlocListener<CreatableTaskCubit, RemoteDataState>(
                  listener: (context, state) {
                if (state is TaskCreating) {
                  redirectToTask(context, state.createdTaskId);
                }
              }),
            ],
            child: Column(
              children: [
                BlocBuilder<OpenTaskCubit, RemoteDataState<Task>>(
                    builder: (context, state) => buildCard(
                          context,
                          state,
                          onTap,
                        )),
                BlocBuilder<ClosedTaskCubit, RemoteDataState<Task>>(
                    builder: (context, state) => buildCard(
                          context,
                          state,
                          onTap,
                        )),
                BlocBuilder<AvailableTaskCubit, RemoteDataState<Task>>(
                    builder: (context, state) => buildCard(
                          context,
                          state,
                          onTap,
                        )),
                // BlocBuilder<CreatableTaskCubit, RemoteDataState>(
                //     builder: (context, state) {
                //   if (state is RemoteDataLoaded<TaskStage>) {
                //     return CreatableTaskList(
                //       items: state.data,
                //       onTap: (TaskStage item) {
                //         final int taskId = item.id;
                //         final selectedCampaign =
                //             context.read<CampaignDetailBloc>().campaignId;
                //         context.go(
                //             '/campaign/$selectedCampaign/tasks/$taskId?$query');
                //       },
                //       icon: iconToDo,
                //     );
                //   }
                //   return const SizedBox.shrink();
                // })
              ],
            ),
          ),
        ),
        endDrawer: const AppDrawer(),
      ),
    );
  }
}

Widget buildCard(BuildContext context, RemoteDataState<Task> state,
    void Function(Task) onTap) {
  if (state is RemoteDataLoaded<Task>) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
          itemCount: state.data.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return FormCard(
              id: state.data[index].id,
              title: state.data[index].name,
              onTap: onTap,
              status: state.data[index].complete,
              task: state.data[index],
            );
          }),
    );
  }
  return const SizedBox.shrink();
}

class CreatableTaskList extends StatelessWidget {
  final List<TaskStage> items;
  final ItemCallback onTap;
  final IconData icon;

  const CreatableTaskList({
    Key? key,
    required this.items,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var item in items)
              SizedBox(
                height: 50.0,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    onTap(item);
                  },
                  child: Text(
                    item.name,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
