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

      final pageData = await fetchAndParseData(0, query: query);

      emit(
        RemoteDataLoaded(
          data: pageData.data,
          currentPage: pageData.currentPage,
          total: pageData.total,
          count: pageData.count,
          query: query,
        ),
      );
    } on Exception catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      emit(RemoteDataFetchingError(e));
    }
  }

  Future<void> fetchData(int page) async {
    try {
      Map<String, dynamic>? query;
      Map<String, dynamic>? body;

      if (state is RemoteDataInitialized<Data>) {
        emit(RemoteDataRefetching.clone(state as RemoteDataInitialized<Data>));
        query = (state as RemoteDataInitialized).query;
        body = (state as RemoteDataInitialized).body;
      } else {
        emit(RemoteDataFetching());
        query = null;
        body = null;
      }

      final pageData = await fetchAndParseData(page, body: body, query: query);

      emit(
        RemoteDataLoaded(
          data: pageData.data,
          currentPage: pageData.currentPage,
          total: pageData.total,
          count: pageData.count,
          query: query,
          body: body,
        ),
      );
    } on Exception catch (e, c) {
      if (kDebugMode) {
        print(e);
        print(c);
      }
      if (state is RemoteDataInitialized<Data>) {
        emit(RemoteDataRefetchingError.clone(state as RemoteDataInitialized<Data>, e));
      } else {
        emit(RemoteDataFetchingError(e));
      }
    }
  }

  Future<void> setFilter(Map<String, dynamic>? query, Map<String, dynamic>? body) async {
    final _state = state;
    if (_state is RemoteDataLoaded<Data>) {
      emit(
        RemoteDataLoaded(
            data: _state.data,
            currentPage: _state.currentPage,
            total: _state.total,
            count: _state.count,
            query: query,
            body: body),
      );
    }
  }

  void refetchWithFilter({Map<String, dynamic>? query, Map<String, dynamic>? body}) {
    setFilter(query, body);
    fetchData(0);
  }

  void refetch() {
    final _state = state;
    final page = _state is RemoteDataInitialized<Data> ? _state.currentPage : 0;

    fetchData(page);
  }

  Future<PageData<Data>> fetchAndParseData(
    int page, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  });
}
