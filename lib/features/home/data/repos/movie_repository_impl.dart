import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movie_task/core/errors/failure.dart';
import 'package:movie_task/features/home/data/data_sources/movie_local_data_source.dart';
import 'package:movie_task/features/home/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_task/features/home/data/models/movies_response.dart';

abstract class MovieRepository {
  Future<Either<Failure, MoviesResponse>> getPopularMovies({
    required int page,
    bool forceRefresh = false,
  });
  Future<void> clearCache();
}

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, MoviesResponse>> getPopularMovies({
    required int page,
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cachedResponse = await localDataSource.getCachedMovies(
          page: page,
        );
        if (cachedResponse != null) {
          log('Loading movies from cache - Page: $page');
          return Right(cachedResponse);
        }
      }

      final remoteResult = await remoteDataSource.getPopularMovies(page: page);
      log('Fetching movies from remote - Page: $page');
      return remoteResult.fold(
        (failure) async {
          final cachedResponse = await localDataSource.getCachedMovies(
            page: page,
          );
          log('Remote fetch failed, checking cache - Page: $page');
          if (cachedResponse != null) {
            return Right(cachedResponse);
          }
          return Left(failure);
        },
        (response) async {
          response.page < 4
              ? await localDataSource.cacheMovies(response)
              : null;
          return Right(response);
        },
      );
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<void> clearCache() async {
    await localDataSource.clearCache();
  }
}
