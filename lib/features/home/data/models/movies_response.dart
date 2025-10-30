import 'package:hive/hive.dart';
import 'package:movie_task/features/home/data/models/movie_model.dart';

part 'movies_response.g.dart';

@HiveType(typeId: 1)
class MoviesResponse extends HiveObject {
  @HiveField(0)
  final int page;

  @HiveField(1)
  final List<MovieModel> results;

  @HiveField(2)
  final int totalPages;

  @HiveField(3)
  final int totalResults;

  @HiveField(4)
  final DateTime cachedAt;

  MoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
    required this.cachedAt,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      page: json['page'] as int? ?? 1,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['total_pages'] as int? ?? 0,
      totalResults: json['total_results'] as int? ?? 0,
      cachedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  bool get hasMorePages => page < totalPages;

  bool isCacheValid(Duration cacheDuration) {
    return DateTime.now().difference(cachedAt) < cacheDuration;
  }

  @override
  String toString() {
    return 'MoviesResponse(page: $page, results: ${results.length}, totalPages: $totalPages)';
  }
}
