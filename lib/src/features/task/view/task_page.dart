import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../bloc/bloc.dart';

class RelevantTaskPage extends StatelessWidget {
  final int campaignId;

  const RelevantTaskPage({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OpenTaskBloc>(
          create: (context) => RelevantTaskBloc(
            OpenTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
        ),
        BlocProvider<ClosedTaskBloc>(
          create: (context) => RelevantTaskBloc(
            ClosedTaskRepository(
              gigaTurnipApiClient: context.read<GigaTurnipApiClient>(),
              campaignId: campaignId,
            ),
          ),
        ),
      ],
      child: const TaskView(),
    );
  }
}

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<OpenTaskBloc, RelevantTaskState>(
    //   builder: (context, state) {
    //     if (state is RelevantTaskLoaded) {
    //       return ListView.builder(itemBuilder: (context, index) {
    //         final item = state.data[index];
    //         return ListTile(
    //           title: Text(item.name),
    //         );
    //       }, itemCount: state.data.length,);
    //     }
    //     return const SizedBox.shrink();
    //   },
    // );
    return SingleChildScrollView(
      child: Column(
        children: [
          RelevantTaskListView(
            bloc: context.read<OpenTaskBloc>() as RelevantTaskBloc,
            header: const Text('Open tasks'),
          ),
          RelevantTaskListView(
            bloc: context.read<ClosedTaskBloc>() as RelevantTaskBloc,
            header: const Text('Closed tasks'),
          ),
        ],
      ),
    );
  }
}

class RelevantTaskListView extends StatelessWidget {
  final RelevantTaskBloc bloc;
  final Text header;

  const RelevantTaskListView({Key? key, required this.bloc, required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is RelevantTaskFetching) {
          return const CircularProgressIndicator();
        }
        if (state is RelevantTaskLoaded) {
          return Column(
            children: [
              header,
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = state.data[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.complete ? 'closed' : 'open'),
                  );
                },
                itemCount: state.data.length,
              ),
              Pagination(
                currentPage: state.currentPage,
                total: state.total,
                onChanged: (page) => bloc.add(FetchRelevantTaskData(page)),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class Pagination extends StatelessWidget {
  final int currentPage;
  final int total;
  final void Function(int page) onChanged;

  const Pagination({
    Key? key,
    required this.currentPage,
    required this.total,
    required this.onChanged,
  }) : super(key: key);

  get hasNext => currentPage < total;

  get hasPrev => currentPage > 0;

  Function handlePage(int page) {
    return () => onChanged(page);
  }

  Function? handleFirstPage() {
    if (hasPrev) {
      return handlePage(0);
    } else {
      return null;
    }
  }

  Function? handlePrevPage() {
    if (hasPrev) {
      return handlePage(currentPage - 1); // hasPrev ? handlePage(currentPage - 1) : handlePage(0);
    } else {
      return null;
    }
  }

  Function? handleNextPage() {
    if (hasNext) {
      return handlePage(currentPage + 1); //currentPage < total - 1 ? handlePage(currentPage - 1) : handlePage(total);
    } else {
      return null;
    }
  }

  Function? handleLastPage() {
    if (hasNext) {
      return handlePage(total); // hasNext ? handlePage(currentPage - 1) : handlePage(total);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: handleFirstPage, icon: const Icon(Icons.skip_previous)),
        IconButton(
            onPressed: currentPage > 0
                ? () {
                    if (currentPage > 0) {
                      onChanged(currentPage - 1);
                    } else {
                      onChanged(0);
                    }
                  }
                : null,
            icon: const Icon(Icons.keyboard_arrow_left)),
        Text('${currentPage + 1}/${total + 1}'),
        IconButton(
            onPressed: currentPage < total
                ? () {
                    if (currentPage < total - 1) {
                      onChanged(currentPage - 1);
                    } else {
                      onChanged(total);
                    }
                  }
                : null,
            icon: const Icon(Icons.keyboard_arrow_right)),
        IconButton(
            onPressed: currentPage < total
                ? () {
                    onChanged(total);
                  }
                : null,
            icon: const Icon(Icons.skip_next)),
      ],
    );
  }
}
