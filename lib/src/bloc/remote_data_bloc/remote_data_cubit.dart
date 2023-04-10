import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'remote_data_state.dart';

abstract class RemoteDataCubit<Data> extends Cubit<RemoteDataState<Data>> {
  RemoteDataCubit() : super(RemoteDataUninitialized());

  Future<void> initialize() async {
    try {
      emit(RemoteDataFetching());

      final pageData = await fetchAndParseData(0);

      emit(
        RemoteDataLoaded(
          data: pageData.data,
          currentPage: pageData.currentPage,
          total: pageData.total,
        ),
      );
    } on Exception catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      emit(RemoteDataFetchingError(e.toString()));
      emit(state);
    }
  }

  Future<void> fetchData(int page) async {
    try {
      emit(RemoteDataRefetching.clone(state as RemoteDataLoaded<Data>));

      final pageData = await fetchAndParseData(page);

      emit(
        RemoteDataLoaded(
          data: pageData.data,
          currentPage: pageData.currentPage,
          total: pageData.total,
        ),
      );
    } on Exception catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      emit(RemoteDataRefetchingError.clone(state as RemoteDataLoaded<Data>, e.toString()));
      emit(state);
    }
  }

  Future<PageData<Data>> fetchAndParseData(int page);
}
