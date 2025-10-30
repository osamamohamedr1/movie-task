import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_task/core/constants/cache_constants.dart';
import 'package:movie_task/features/home/data/models/movies_response.dart';

abstract class MovieLocalDataSource {
  Future<MoviesResponse?> getCachedMovies({required int page});
  Future<void> cacheMovies(MoviesResponse response);
  Future<void> clearCache();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  late Box<MoviesResponse> _moviesBox;

  MovieLocalDataSourceImpl() {
    _initHive();
  }

  Future<void> _initHive() async {
    if (!Hive.isBoxOpen(CacheConstants.moviesBox)) {
      _moviesBox = await Hive.openBox<MoviesResponse>(CacheConstants.moviesBox);
    } else {
      _moviesBox = Hive.box<MoviesResponse>(CacheConstants.moviesBox);
    }
  }

  String _getPageKey(int page) =>
      '${CacheConstants.popularMoviesKey}_page_$page';

  @override
  Future<MoviesResponse?> getCachedMovies({required int page}) async {
    await _initHive();

    try {
      final cachedResponse = _moviesBox.get(_getPageKey(page));
      return cachedResponse;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheMovies(MoviesResponse response) async {
    await _initHive();

    try {
      final pageKey = _getPageKey(response.page);
      if (response.page < 4) {
        await _moviesBox.put(pageKey, response);
      }
    } catch (e) {
      print('Error caching movies: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    await _initHive();
    try {
      await _moviesBox.clear();
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }
}
