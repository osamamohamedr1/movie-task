import 'package:flutter/material.dart';
import 'package:movie_task/features/home/data/models/movie_model.dart';
import 'package:movie_task/features/home/presentation/views/widgets/rating_widget.dart';
import 'package:movie_task/features/home/presentation/views/widgets/genre_chip.dart';

class MovieInfoSection extends StatelessWidget {
  final MovieModel movie;

  const MovieInfoSection({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Movie Title
        Text(
          movie.title,
          style: Theme.of(context).textTheme.titleLarge,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        
        const SizedBox(height: 8),
        
        // Rating
        RatingWidget(rating: movie.voteAverage),
        
        const SizedBox(height: 8),
        
        // Genre
        GenreChip(genre: movie.getGenreNames()),
      ],
    );
  }
}
