String toQueryString(Map<String, String> query, [String? removeKey]) {
  final newQuery = {...query};
  if (removeKey != null) {
    newQuery.remove(removeKey);
  }
  return Uri(queryParameters: newQuery).query;
}
