bool shouldRefreshFromApi(Duration cacheValidDuration, DateTime lastFetchTime, bool forceRefresh) {
  return lastFetchTime.isBefore(DateTime.now().subtract(cacheValidDuration)) || forceRefresh;
}
