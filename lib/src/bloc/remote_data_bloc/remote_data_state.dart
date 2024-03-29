part of 'remote_data_cubit.dart';

abstract class RemoteDataState<Data> extends Equatable {
  @override
  List<Object?> get props => [];
}

mixin RemoteDataLoading<Data> on RemoteDataState<Data> {}

mixin RemoteDataFailed<Data> on RemoteDataState<Data> {
  late final Exception error;
}

class RemoteDataUninitialized<Data> extends RemoteDataState<Data> {}

class RemoteDataFetching<Data> extends RemoteDataState<Data> with RemoteDataLoading<Data> {}

class RemoteDataFetchingError<Data> extends RemoteDataState<Data> with RemoteDataFailed<Data> {
  RemoteDataFetchingError(Exception error) {
    this.error = error;
  }

  @override
  List<Object?> get props => [error];
}

abstract class RemoteDataInitialized<Data> extends RemoteDataState<Data> {
  final List<Data> data;
  final int currentPage;
  final int total;
  final int count;
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? body;

  RemoteDataInitialized({
    required this.data,
    required this.currentPage,
    required this.total,
    required this.count,
    required this.query,
    required this.body,
  });

  RemoteDataInitialized.clone(RemoteDataInitialized<Data> state)
      : this(
          data: state.data,
          currentPage: state.currentPage,
          total: state.total,
          count: state.count,
          query: state.query,
          body: state.body,
        );

  @override
  List<Object?> get props => [data, currentPage, total, query, count, body];
}

class RemoteDataLoaded<Data> extends RemoteDataInitialized<Data> {
  RemoteDataLoaded({
    required super.data,
    required super.currentPage,
    required super.total,
    required super.count,
    super.query,
    super.body,
  });

  RemoteDataLoaded.clone(RemoteDataInitialized<Data> state) : super.clone(state);
}

class RemoteDataRefetching<Data> extends RemoteDataInitialized<Data> with RemoteDataLoading<Data> {
  RemoteDataRefetching({
    required super.data,
    required super.currentPage,
    required super.total,
    required super.count,
    super.query,
    super.body,
  });

  RemoteDataRefetching.clone(RemoteDataInitialized<Data> state) : super.clone(state);
}

class RemoteDataRefetchingError<Data> extends RemoteDataInitialized<Data>
    with RemoteDataFailed<Data> {
  RemoteDataRefetchingError({
    required Exception error,
    required super.data,
    required super.currentPage,
    required super.total,
    required super.count,
    super.query,
    super.body,
  }) {
    this.error = error;
  }

  RemoteDataRefetchingError.clone(RemoteDataInitialized<Data> state, Exception error)
      : super.clone(state) {
    this.error = error;
  }

  @override
  List<Object?> get props => [...super.props, error];
}
