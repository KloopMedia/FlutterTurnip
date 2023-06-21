class PageData<Data> {
  final List<Data> data;
  final int currentPage;
  final int total;
  final int count;

  PageData({required this.data, required this.currentPage, required this.total, required this.count});
}
