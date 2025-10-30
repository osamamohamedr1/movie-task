class CacheConstants {
  CacheConstants._();

  // Box names
  static const String moviesBox = 'movies_box6';
  static const String movieDetailsBox = 'movie_details_box4';
  static const String themeBox = 'themeBox';

  // Cache duration
  static const Duration cacheDuration = Duration(hours: 24);

  // Cache keys
  static const String popularMoviesKey = 'popular_movies';
  static const String lastCacheTimeKey = 'last_cache_time';

  // Pagination
  static const int itemsPerPage = 20;
  static const int maxCachedPages = 5;
}
