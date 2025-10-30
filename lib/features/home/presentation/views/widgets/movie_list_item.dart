import 'package:flutter/material.dart';
import 'package:movie_task/core/constants/api_constants.dart';
import 'package:movie_task/features/home/data/models/movie_model.dart';
import 'package:movie_task/features/home/presentation/views/widgets/movie_poster.dart';
import 'package:movie_task/features/home/presentation/views/widgets/movie_info_section.dart';

class MovieListItem extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onTap;

  const MovieListItem({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie.posterPath != null
        ? ApiConstants.getPosterUrl(movie.posterPath!)
        : null;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoviePoster(posterUrl: posterUrl, width: 80, height: 120),

              const SizedBox(width: 12),

              Expanded(child: MovieInfoSection(movie: movie)),

              Icon(
                Icons.chevron_right,
                color: Theme.of(context).iconTheme.color,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
