import 'package:gigaturnip_api/gigaturnip_api.dart' as api;
import 'package:gigaturnip_repository/src/models/page_data.dart';

abstract class GigaTurnipRepository<Data> {
  final int limit;

  GigaTurnipRepository({this.limit = 10});

  int calculateOffset(int page) {
    return page * limit;
  }

  int calculateTotalPage(int total) {
    final totalWithOffset = (total - 1).isNegative ? 0 : total - 1;
    return (totalWithOffset / limit).floor();
  }

  Future<PageData<Data>> fetchDataOnPage(int page, [Map<String, dynamic>? query]) async {
    final paginationQuery = {
      'limit': limit,
      'offset': calculateOffset(page),
      ...?query,
    };
    final data = await fetchAndParseData(query: paginationQuery);

    return PageData(
      data: data.results,
      currentPage: page,
      total: calculateTotalPage(data.count),
      count: data.count,
    );
  }

  Future<api.PaginationWrapper<Data>> fetchAndParseData({Map<String, dynamic>? query});
}