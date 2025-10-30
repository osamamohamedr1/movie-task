import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_task/core/theme/app_colors.dart';

class MoviePoster extends StatelessWidget {
  final String? posterUrl;
  final double width;
  final double height;

  const MoviePoster({
    super.key,
    this.posterUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: posterUrl != null
          ? CachedNetworkImage(
              imageUrl: posterUrl!,
              width: width,
              height: height,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCardBackground
                      : AppColors.imagePlaceholder,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDark ? AppColors.accentCyan : AppColors.primaryBlue,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCardBackground
                      : AppColors.imagePlaceholder,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: isDark
                        ? AppColors.darkIconColor.withOpacity(0.5)
                        : AppColors.lightIconColor.withOpacity(0.5),
                    size: 32,
                  ),
                ),
              ),
            )
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkCardBackground
                    : AppColors.imagePlaceholder,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.hide_image_outlined,
                  color: isDark
                      ? AppColors.darkIconColor.withOpacity(0.5)
                      : AppColors.lightIconColor.withOpacity(0.5),
                  size: 32,
                ),
              ),
            ),
    );
  }
}
