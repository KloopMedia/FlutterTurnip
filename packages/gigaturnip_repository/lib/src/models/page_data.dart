class PageData<Data> {
  final List<Data> data;
  final int currentPage;
  final int total;
  final int count;

  PageData(
      {required this.data, required this.currentPage, required this.total, required this.count});

  PageData<Data> copyWith({List<Data>? data, int? currentPage, int? total, int? count}) {
    return PageData(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      total: total ?? this.total,
      count: count ?? this.count,
    );
  }
}
