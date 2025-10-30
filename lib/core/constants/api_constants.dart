class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String posterSize = 'w500';
  static const String backdropSize = 'w780';

  static const String apiKey = 'e7d8b9cd068e842b82c1fc62b204ee5e';
  static const String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlN2Q4YjljZDA2OGU4NDJiODJjMWZjNjJiMjA0ZWU1ZSIsIm5iZiI6MTc2MTcyNjQ4Ni40MDMsInN1YiI6IjY5MDFkMDE2ZjBiZTQxN2U1ZTczYjJmZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ISDzUWmryhGN1IHuZCoP6g5YJmjb5NaOVoK3TG27fC4';

  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String movieDetails = '/movie';

  // Query Parameters
  static const String languageParam = 'language';
  static const String pageParam = 'page';
  static const String defaultLanguage = 'en-US';

  // Image URLs
  static String getPosterUrl(String posterPath) {
    return '$imageBaseUrl/$posterSize$posterPath';
  }

  static String getBackdropUrl(String backdropPath) {
    return '$imageBaseUrl/$backdropSize$backdropPath';
  }
}
