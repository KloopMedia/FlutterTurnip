part of 'remote_data_cubit.dart';

abstract class RemoteDataState<Data> extends Equatable {
  @override
  List<Object?> get props => [];
}

mixin RemoteDataLoading<Data> on RemoteDataState<Data> {}

mixin RemoteDataFailed<Data> on RemoteDataState<Data> {
  late final String error;
}

class RemoteDataUninitialized<Data> extends RemoteDataState<Data> {}

class RemoteDataFetching<Data> extends RemoteDataState<Data> with RemoteDataLoading<Data> {}

class RemoteDataFetchingError<Data> extends RemoteDataState<Data> with RemoteDataFailed<Data> {
  RemoteDataFetchingError(String error) {
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

  RemoteDataInitialized({
    required this.data,
    required this.currentPage,
    required this.total,
    required this.count,
    required this.query,
  });

  RemoteDataInitialized.clone(RemoteDataInitialized<Data> state)
      : this(
          data: state.data,
          currentPage: state.currentPage,
          total: state.total,
          count: state.count,
          query: state.query,
        );

  @override
  List<Object?> get props => [data, currentPage, total, query, count];
}

class RemoteDataLoaded<Data> extends RemoteDataInitialized<Data> {
  RemoteDataLoaded({
    required super.data,
    required super.currentPage,
    required super.total,
    required super.count,
    super.query,
  });
}

class RemoteDataRefetching<Data> extends RemoteDataInitialized<Data> with RemoteDataLoading<Data> {
  RemoteDataRefetching({
    required super.data,
    required super.currentPage,
    required super.total,
    required super.count,
    super.query,
  });

  RemoteDataRefetching.clone(RemoteDataInitialized<Data> state) : super.clone(state);
}

class RemoteDataRefetchingError<Data> extends RemoteDataInitialized<Data>
    with RemoteDataFailed<Data> {
  RemoteDataRefetchingError({
    required String error,
    required super.data,
    required super.currentPage,
    required super.total,
    required super.count,
    super.query,
  }) {
    this.error = error;
  }

  RemoteDataRefetchingError.clone(RemoteDataInitialized<Data> state, String error)
      : super.clone(state) {
    this.error = error;
  }

  @override
  List<Object?> get props => [...super.props, error];
}
