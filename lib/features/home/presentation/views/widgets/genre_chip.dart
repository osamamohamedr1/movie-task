import 'package:flutter/material.dart';
import 'package:movie_task/core/theme/app_colors.dart';

class GenreChip extends StatelessWidget {
  final String genre;

  const GenreChip({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkGenreChipBackground
            : AppColors.genreChipBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        genre,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
      ),
    );
  }
}
