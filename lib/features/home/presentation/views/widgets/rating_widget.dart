import 'package:flutter/material.dart';
import 'package:movie_task/core/theme/app_colors.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: AppColors.starYellow, size: 18),
        const SizedBox(width: 4),
        Text(
          '${rating.toStringAsFixed(1)} / 10',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
