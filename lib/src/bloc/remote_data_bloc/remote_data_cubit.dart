import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'remote_data_state.dart';

abstract class RemoteDataCubit<Data> extends Cubit<RemoteDataState<Data>> {
  RemoteDataCubit() : super(RemoteDataUninitialized());

  Future<void> initialize({Map<String, dynamic>? query}) async {
    try {
      emit(RemoteDataFetching());

      final pageData = await fetchAndParseData(0, query);

      emit(
        RemoteDataLoaded(
          data: pageData.data,
          currentPage: pageData.currentPage,
          total: pageData.total,
          query: query,
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
      emit(RemoteDataRefetching.clone(state as RemoteDataInitialized<Data>));

      final query = (state as RemoteDataInitialized).query;

      final pageData = await fetchAndParseData(page, query);

      emit(
        RemoteDataLoaded(
          data: pageData.data,
          currentPage: pageData.currentPage,
          total: pageData.total,
          query: query,
        ),
      );
    } on Exception catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      emit(RemoteDataRefetchingError.clone(state as RemoteDataInitialized<Data>, e.toString()));
      emit(state);
    }
  }

  Future<void> setFilter(Map<String, dynamic>? query) async {
    final _state = state;
    if (_state is RemoteDataLoaded<Data>) {
      emit(
        RemoteDataLoaded(
          data: _state.data,
          currentPage: _state.currentPage,
          total: _state.total,
          query: query,
        ),
      );
    }
  }

  void refetchWithFilter(Map<String, dynamic>? query) {
    setFilter(query);
    fetchData(0);
  }

  void refetch() {
    final _state = state as RemoteDataInitialized<Data>;
    fetchData(_state.currentPage);
  }

  Future<PageData<Data>> fetchAndParseData(int page, [Map<String, dynamic>? query]);
}
