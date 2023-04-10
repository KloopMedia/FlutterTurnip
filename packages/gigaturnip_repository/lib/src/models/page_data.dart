class PageData<Data> {
  final List<Data> data;
  final int currentPage;
  final int total;

  PageData({required this.data, required this.currentPage, required this.total});
}
