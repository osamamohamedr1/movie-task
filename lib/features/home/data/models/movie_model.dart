import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double voteAverage;

  @HiveField(3)
  final List<int> genreIds;

  @HiveField(4)
  final String overview;

  @HiveField(5)
  final String? posterPath;

  @HiveField(6)
  final String? backdropPath;

  @HiveField(7)
  final String releaseDate;

  @HiveField(8)
  final double popularity;

  @HiveField(9)
  final bool adult;

  @HiveField(10)
  final String originalLanguage;

  @HiveField(11)
  final String originalTitle;

  MovieModel({
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.genreIds,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    required this.popularity,
    required this.adult,
    required this.originalLanguage,
    required this.originalTitle,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      adult: json['adult'] as bool? ?? false,
      originalLanguage: json['original_language'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'vote_average': voteAverage,
      'genre_ids': genreIds,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'popularity': popularity,
      'adult': adult,
      'original_language': originalLanguage,
      'original_title': originalTitle,
    };
  }

  // Helper method to get genre name
  String getGenreNames() {
    final genreMap = {
      28: 'Action',
      12: 'Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      14: 'Fantasy',
      36: 'History',
      27: 'Horror',
      10402: 'Music',
      9648: 'Mystery',
      10749: 'Romance',
      878: 'Sci-Fi',
      10770: 'TV Movie',
      53: 'Thriller',
      10752: 'War',
      37: 'Western',
    };

    if (genreIds.isEmpty) return 'Unknown';
    return genreMap[genreIds.first] ?? 'Unknown';
  }

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, rating: $voteAverage)';
  }
}
