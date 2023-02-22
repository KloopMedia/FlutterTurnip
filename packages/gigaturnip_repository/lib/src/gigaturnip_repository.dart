import 'package:gigaturnip_api/gigaturnip_api.dart';

abstract class GigaTurnipRepository<Raw, Data> {
  int currentPage = 0;
  int pageLimit = 10;
  int pageTotal = 0;
  bool hasNextPage = false;
  bool hasPreviousPage = false;

  int _calculateOffset(int page) {
    return page * pageLimit;
  }

  int _calculateTotalPage(int total) {
    return (total / pageLimit).ceil();
  }

  Future<List<Data>> fetchNextPage() {
    return fetchDataOnPage(currentPage + 1);
  }

  Future<List<Data>> fetchPreviousPage() {
    return fetchDataOnPage(currentPage - 1);
  }

  Future<List<Data>> fetchDataOnPage(int page) async {
    final paginationQuery = {
      'limit': pageLimit,
      'offset': _calculateOffset(page),
    };
    final data = await fetchData(query: paginationQuery);

    pageTotal = _calculateTotalPage(data.count);
    hasNextPage = data.hasNext;
    hasPreviousPage = data.hasPrevious;

    return parseData(data.results);
  }

  Future<PaginationWrapper<Raw>> fetchData({Map<String, dynamic>? query});

  List<Data> parseData(List<Raw> data);
}
