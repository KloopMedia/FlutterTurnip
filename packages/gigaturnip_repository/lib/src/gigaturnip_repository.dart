import 'package:gigaturnip_api/gigaturnip_api.dart' as api;

abstract class GigaTurnipRepository<Raw, Data> {
  final int _pageLimit = 10;

  int _currentPage = 0;
  int _pageTotal = 0;
  bool _hasNextPage = false;
  bool _hasPreviousPage = false;

  get currentPage => _currentPage;

  get total => _pageTotal;

  get hasNextPage => _hasNextPage;

  get hasPreviousPage => _hasPreviousPage;

  int _calculateOffset(int page) {
    return page * _pageLimit;
  }

  int _calculateTotalPage(int total) {
    return (total / _pageLimit).floor();
  }

  Future<List<Data>> fetchNextPage() {
    return fetchDataOnPage(_currentPage + 1);
  }

  Future<List<Data>> fetchPreviousPage() {
    return fetchDataOnPage(_currentPage - 1);
  }

  Future<List<Data>> fetchDataOnPage(int page) async {
    final paginationQuery = {
      'limit': _pageLimit,
      'offset': _calculateOffset(page),
    };
    final data = await fetchData(query: paginationQuery);

    _pageTotal = _calculateTotalPage(data.count);
    _currentPage = page;
    _hasNextPage = data.hasNext;
    _hasPreviousPage = data.hasPrevious;

    return parseData(data.results);
  }

  Future<api.PaginationWrapper<Raw>> fetchData({Map<String, dynamic>? query});

  List<Data> parseData(List<Raw> data);
}
