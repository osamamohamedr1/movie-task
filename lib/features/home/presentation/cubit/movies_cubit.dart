import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/features/home/data/repos/movie_repository_impl.dart';
import 'package:movie_task/features/home/presentation/cubit/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository movieRepository;

  MoviesCubit({required this.movieRepository}) : super(const MoviesInitial());

  Future<void> loadMovies({bool forceRefresh = false}) async {
    emit(const MoviesLoading());

    final result = await movieRepository.getPopularMovies(
      page: 1,
      forceRefresh: forceRefresh,
    );

    result.fold(
      (failure) => emit(MoviesError(message: failure.errorMessage)),
      (response) => emit(
        MoviesSuccess(
          movies: response.results,
          currentPage: response.page,
          hasMorePages: response.hasMorePages,
        ),
      ),
    );
  }

  Future<void> loadMoreMovies() async {
    if (state is! MoviesSuccess) return;

    final currentState = state as MoviesSuccess;
    if (!currentState.hasMorePages) return;

    emit(
      MoviesLoadingMore(
        currentMovies: currentState.movies,
        currentPage: currentState.currentPage,
      ),
    );

    final nextPage = currentState.currentPage + 1;
    final result = await movieRepository.getPopularMovies(
      page: nextPage,
      forceRefresh: false,
    );

    result.fold(
      (failure) {
        // Keep current movies on error
        emit(
          MoviesSuccess(
            movies: currentState.movies,
            currentPage: currentState.currentPage,
            hasMorePages: currentState.hasMorePages,
          ),
        );
      },
      (response) {
        final updatedMovies = [...currentState.movies, ...response.results];
        emit(
          MoviesSuccess(
            movies: updatedMovies,
            currentPage: response.page,
            hasMorePages: response.hasMorePages,
          ),
        );
      },
    );
  }

  Future<void> refreshMovies() async {
    final result = await movieRepository.getPopularMovies(
      page: 1,
      forceRefresh: true,
    );

    result.fold(
      (failure) {
        // Keep current state if available
        if (state is MoviesSuccess) {
          final currentState = state as MoviesSuccess;
          emit(
            MoviesSuccess(
              movies: currentState.movies,
              currentPage: currentState.currentPage,
              hasMorePages: currentState.hasMorePages,
            ),
          );
        }
      },
      (response) => emit(
        MoviesSuccess(
          movies: response.results,
          currentPage: response.page,
          hasMorePages: response.hasMorePages,
        ),
      ),
    );
  }
}
