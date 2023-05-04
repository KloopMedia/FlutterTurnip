import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/src/models/page_data.dart';

abstract class GigaTurnipRepository<Raw, Data> {
  final int limit;

  GigaTurnipRepository({this.limit = 10});

  int _calculateOffset(int page) {
    return page * limit;
  }

  int _calculateTotalPage(int total) {
    final totalWithOffset = (total - 1).isNegative ? 0 : total - 1;
    return (totalWithOffset / limit).floor();
  }

  Future<PageData<Data>> fetchDataOnPage(int page, [Map<String, dynamic>? query]) async {
    final paginationQuery = {
      'limit': limit,
      'offset': _calculateOffset(page),
      ...?query,
    };
    final data = await fetchData(query: paginationQuery);

    return PageData(
      data: parseData(data.results),
      currentPage: page,
      total: _calculateTotalPage(data.count),
    );
  }

  Future<api.PaginationWrapper<Raw>> fetchData({Map<String, dynamic>? query});

  List<Data> parseData(List<Raw> data);
}
