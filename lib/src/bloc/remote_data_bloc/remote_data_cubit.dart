import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

part 'remote_data_state.dart';

abstract class RemoteDataCubit<Data> extends Cubit<RemoteDataState<Data>> {
  RemoteDataCubit() : super(RemoteDataUninitialized());

  Future<void> initialize({Map<String, dynamic>? query}) async {
    await _loadPage(0, query: query, refetching: false);
  }

  Future<void> fetchData(int page, {Map<String, dynamic>? query}) async {
    final currentState = state;
    final effectiveQuery = query ?? _currentQueryOrNull(currentState);
    final effectiveBody = _currentBodyOrNull(currentState);

    await _loadPage(
      page,
      query: effectiveQuery,
      body: effectiveBody,
      refetching: currentState is RemoteDataInitialized<Data>,
    );
  }

  Future<void> setFilter(Map<String, dynamic>? query, Map<String, dynamic>? body) async {
    if (state is RemoteDataLoaded<Data>) {
      final currentState = state as RemoteDataLoaded<Data>;
      emit(RemoteDataLoaded(
        data: currentState.data,
        currentPage: currentState.currentPage,
        total: currentState.total,
        count: currentState.count,
        query: query,
        body: body,
      ));
    }
  }

  void refetchWithFilter({Map<String, dynamic>? query, Map<String, dynamic>? body}) {
    setFilter(query, body);
    fetchData(0, query: query);
  }

  void refetch() {
    final currentPage = state is RemoteDataInitialized<Data>
        ? (state as RemoteDataInitialized<Data>).currentPage
        : 0;
    fetchData(currentPage);
  }

  /// This must be implemented by subclasses to fetch data.
  Future<PageData<Data>> fetchAndParseData(
      int page, {
        Map<String, dynamic>? body,
        Map<String, dynamic>? query,
      });

  /// Unified method to handle loading pages and emitting states
  Future<void> _loadPage(
      int page, {
        Map<String, dynamic>? query,
        Map<String, dynamic>? body,
        bool refetching = false,
      }) async {
    try {
      emit(_loadingStateFromCurrent(state, refetching));
      final pageData = await fetchAndParseData(page, query: query, body: body);

      emit(RemoteDataLoaded<Data>(
        data: pageData.data,
        currentPage: pageData.currentPage,
        total: pageData.total,
        count: pageData.count,
        query: query,
        body: body,
      ));
    } catch (error, stackTrace) {
      _handleError(state, error, stackTrace);
    }
  }

  RemoteDataState<Data> _loadingStateFromCurrent(RemoteDataState<Data> currentState, bool refetching) {
    if (refetching && currentState is RemoteDataInitialized<Data>) {
      return RemoteDataRefetching.clone(currentState);
    }
    return RemoteDataFetching();
  }

  void _handleError(RemoteDataState<Data> currentState, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print(error);
      print(stackTrace);
    }

    final exception = error is Exception ? error : Exception(error.toString());
    if (currentState is RemoteDataInitialized<Data>) {
      emit(RemoteDataRefetchingError.clone(currentState, exception));
    } else {
      emit(RemoteDataFetchingError(exception));
    }
  }

  Map<String, dynamic>? _currentQueryOrNull(RemoteDataState<Data> state) {
    return state is RemoteDataInitialized<Data> ? state.query : null;
  }

  Map<String, dynamic>? _currentBodyOrNull(RemoteDataState<Data> state) {
    return state is RemoteDataInitialized<Data> ? state.body : null;
  }
}