import 'package:flutter/material.dart';
import 'package:movie_task/core/constants/api_constants.dart';
import 'package:movie_task/features/home/data/models/movie_model.dart';
import 'package:movie_task/features/home/presentation/views/widgets/movie_poster.dart';
import 'package:movie_task/features/home/presentation/views/widgets/rating_widget.dart';
import 'package:movie_task/features/home/presentation/views/widgets/genre_chip.dart';

class MovieDetailsView extends StatelessWidget {
  final MovieModel movie;
  final bool isDarkMode;

  const MovieDetailsView({
    super.key,
    required this.movie,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie.posterPath != null
        ? ApiConstants.getPosterUrl(movie.posterPath!)
        : null;

    return Theme(
      data: isDarkMode 
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: const Color(0xFF121212),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1E1E1E),
                foregroundColor: Color(0xFF00BCD4),
                elevation: 0,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  color: Color(0xFF00BCD4),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                iconTheme: IconThemeData(
                  color: Color(0xFF00BCD4),
                  size: 24,
                ),
              ),
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: const Color(0xFFF5F5F5),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF2196F3),
                foregroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Movie Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Poster
                Center(
                  child: MoviePoster(
                    posterUrl: posterUrl,
                    width: 200,
                    height: 300,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Movie Title
                Text(
                  movie.title,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Rating
                RatingWidget(rating: movie.voteAverage),
                
                const SizedBox(height: 12),
                
                // Genre
                GenreChip(genre: movie.getGenreNames()),
                
                const SizedBox(height: 24),
                
                // Description Label
                Text(
                  'Description',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Description Text
                Text(
                  movie.overview.isNotEmpty 
                      ? movie.overview 
                      : 'No description available.',
                  style: TextStyle(
                    color: isDarkMode 
                        ? const Color(0xFFB0B0B0) 
                        : const Color(0xFF757575),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Release Date
                if (movie.releaseDate.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Release Date',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.releaseDate,
                        style: TextStyle(
                          color: isDarkMode 
                              ? const Color(0xFFB0B0B0) 
                              : const Color(0xFF757575),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
