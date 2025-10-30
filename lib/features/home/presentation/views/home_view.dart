import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/core/di/service_locator.dart';
import 'package:movie_task/core/theme/cubit/theme_cubit.dart';
import 'package:movie_task/features/home/data/models/movie_model.dart';
import 'package:movie_task/features/home/presentation/cubit/movies_cubit.dart';
import 'package:movie_task/features/home/presentation/cubit/movies_state.dart';
import 'package:movie_task/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:movie_task/features/home/presentation/views/widgets/movie_list_item.dart';
import 'package:movie_task/features/home/presentation/views/movie_details_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MoviesCubit>()..loadMovies(),
      child: const HomeViewBody(),
    );
  }
}

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<MoviesCubit>().loadMoreMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToDetails(MovieModel movie, bool isDarkMode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MovieDetailsView(movie: movie, isDarkMode: isDarkMode),
      ),
    );
  }

  Widget _buildMoviesList(
    List<MovieModel> movies,
    bool isLoadingMore,
    bool isDarkMode, {
    bool hasMorePages = false,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<MoviesCubit>().refreshMovies();
      },
      color: isDarkMode ? const Color(0xFF00BCD4) : const Color(0xFF2196F3),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieListItem(
                  movie: movie,
                  onTap: () => navigateToDetails(movie, isDarkMode),
                );
              },
            ),
          ),
          if (isLoadingMore)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: isDarkMode
                    ? const Color(0xFF00BCD4)
                    : const Color(0xFF2196F3),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;

        return Scaffold(
          appBar: const HomeAppBar(),
          body: BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              return switch (state) {
                MoviesInitial() => Center(
                  child: CircularProgressIndicator(
                    color: isDarkMode
                        ? const Color(0xFF00BCD4)
                        : const Color(0xFF2196F3),
                  ),
                ),
                MoviesLoading() => Center(
                  child: CircularProgressIndicator(
                    color: isDarkMode
                        ? const Color(0xFF00BCD4)
                        : const Color(0xFF2196F3),
                  ),
                ),
                MoviesError(:final message, :final previousMovies)
                    when previousMovies.isEmpty =>
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 80,
                            color: isDarkMode
                                ? Colors.red.shade300
                                : Colors.red,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Oops! Something went wrong',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<MoviesCubit>().loadMovies(
                                forceRefresh: true,
                              );
                            },
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Try Again'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode
                                  ? const Color(0xFF00BCD4)
                                  : const Color(0xFF2196F3),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                MoviesError(:final previousMovies) => _buildMoviesList(
                  previousMovies,
                  false,
                  isDarkMode,
                ),
                MoviesLoadingMore(:final currentMovies) => _buildMoviesList(
                  currentMovies,
                  true,
                  isDarkMode,
                ),
                MoviesSuccess(:final movies) when movies.isEmpty => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.movie_outlined,
                        size: 80,
                        color: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No movies found',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                MoviesSuccess(:final movies, :final hasMorePages) =>
                  _buildMoviesList(
                    movies,
                    false,
                    isDarkMode,
                    hasMorePages: hasMorePages,
                  ),
              };
            },
          ),
        );
      },
    );
  }
}
