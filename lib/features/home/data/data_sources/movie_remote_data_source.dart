import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_task/core/constants/api_constants.dart';
import 'package:movie_task/core/errors/failure.dart';
import 'package:movie_task/core/networking/api_service.dart';
import 'package:movie_task/features/home/data/models/movies_response.dart';

abstract class MovieRemoteDataSource {
  Future<Either<Failure, MoviesResponse>> getPopularMovies({required int page});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiService apiService;

  MovieRemoteDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, MoviesResponse>> getPopularMovies({
    required int page,
  }) async {
    try {
      final response = await apiService.get(
        endPoints: ApiConstants.popularMovies,
        queryParams: {
          ApiConstants.languageParam: ApiConstants.defaultLanguage,
          ApiConstants.pageParam: page,
        },
      );

      final moviesResponse = MoviesResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Right(moviesResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
