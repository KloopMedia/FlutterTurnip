import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigaturnip/src/bloc/bloc.dart';

import 'pagination.dart';

class ListViewWithPagination<Data, Cubit extends RemoteDataCubit<Data>> extends StatelessWidget {
  final Widget? header;
  final Widget? Function(BuildContext context, int index, Data item) itemBuilder;

  const ListViewWithPagination({
    Key? key,
    this.header,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        BlocBuilder<Cubit, RemoteDataState<Data>>(
          builder: (context, state) {
            if (state is RemoteDataLoading<Data>) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is RemoteDataFailed<Data>) {
              return Center(child: Text(state.error));
            }
            if (state is RemoteDataLoaded<Data>) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => itemBuilder(context, index, state.data[index]),
                itemCount: state.data.length,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        BlocBuilder<Cubit, RemoteDataState<Data>>(
          builder: (context, state) {
            return Pagination(
              currentPage: state is RemoteDataInitialized<Data> ? state.currentPage : 0,
              total: state is RemoteDataInitialized<Data> ? state.total : 0,
              onChanged: (page) => context.read<Cubit>().fetchData(page),
              enabled: state is! RemoteDataLoading,
            );
          },
        )
      ],
    );
  }
}
