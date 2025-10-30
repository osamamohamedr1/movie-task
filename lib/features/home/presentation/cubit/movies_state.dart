import 'package:movie_task/features/home/data/models/movie_model.dart';

sealed class MoviesState {
  const MoviesState();
}

class MoviesInitial extends MoviesState {
  const MoviesInitial();
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class MoviesSuccess extends MoviesState {
  final List<MovieModel> movies;
  final int currentPage;
  final bool hasMorePages;
  final bool isLoadedFromCache;

  const MoviesSuccess({
    required this.movies,
    required this.currentPage,
    required this.hasMorePages,
    this.isLoadedFromCache = false,
  });
}

class MoviesLoadingMore extends MoviesState {
  final List<MovieModel> currentMovies;
  final int currentPage;

  const MoviesLoadingMore({
    required this.currentMovies,
    required this.currentPage,
  });
}

class MoviesError extends MoviesState {
  final String message;
  final List<MovieModel> previousMovies;

  const MoviesError({required this.message, this.previousMovies = const []});
}
