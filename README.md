# Movie Task

A Flutter movie application that displays popular movies from TMDB API with offline support and infinite scrolling.

## 📱 Screenshots

| Light Mode | Dark Mode | Movie Details |
|------------|-----------|---------------|
| ![Light Mode](screenshots/light_mode.png) | ![Dark Mode](screenshots/dark_mode.png) | ![Movie Details](screenshots/movie_details.png) |

## ✨ Features

### 🎬 Core Features
- **Browse Popular Movies** - Display trending movies from TMDB
- **Movie Details** - View full movie information including poster, rating, genre, and description
- **Theme Toggle** - Switch between light and dark themes
- **Offline Support** - Cache movies locally for offline viewing
- **Infinite Scrolling** - Load more movies automatically as you scroll

### 🎨 UI/UX
- **Material Design 3** - Modern, clean interface
- **Responsive Design** - Optimized for different screen sizes
- **Smooth Animations** - Loading indicators and transitions
- **Pull to Refresh** - Refresh movie list with swipe gesture

## 🚀 Architecture

### Clean Architecture (Data Layer)
```
lib/
├── core/
│   ├── constants/      # API keys, cache settings
│   ├── di/            # Dependency injection (GetIt)
│   ├── errors/        # Error handling with Failure classes
│   ├── networking/    # API service with Dio
│   ├── routing/       # Navigation
│   └── theme/         # App themes and colors
└── features/
    └── home/
        ├── data/
        │   ├── models/           # Movie models with Hive
        │   ├── data_sources/     # Remote & Local data sources
        │   └── repos/            # Repository implementation
        └── presentation/
            ├── cubit/            # State management
            └── views/            # UI screens and widgets
```

### State Management
- **flutter_bloc** - Cubit pattern with sealed classes
- **State Types:**
  - `MoviesInitial` - Initial state
  - `MoviesLoading` - Loading first page
  - `MoviesSuccess` - Data loaded successfully
  - `MoviesLoadingMore` - Loading additional pages
  - `MoviesError` - Error occurred

## 💾 Caching System

### How It Works
```dart
// Cache-first strategy
1. Check local cache → If exists, return immediately
2. If cache miss → Fetch from API
3. Save API response to cache
4. If API fails → Fallback to cached data (if available)
```

### Cache Features
- **Hive Database** - Fast, lightweight local storage
- **Per-Page Caching** - Each page cached separately
- **Offline-First** - Works without internet connection
- **Smart Fallback** - Shows cached data when API fails

### Cache Flow
```
User Opens App
      ↓
Check Cache (Page 1)
   ↓         ↓
Exists    Not Exists
   ↓         ↓
Return    Fetch API
Cache        ↓
          Success?
         ↓       ↓
        Yes      No
         ↓       ↓
      Cache   Check Cache
         ↓       Again
      Return     ↓
              Return or Error
```

## 📄 Pagination

### Infinite Scroll Implementation
```dart
// Automatic loading when user scrolls to 90% of the list
_scrollController.addListener(() {
  if (position >= maxScrollExtent * 0.9) {
    loadMoreMovies();
  }
});
```

### Pagination Features
- **Scroll Detection** - Load more at 90% scroll position
- **State Preservation** - Old movies never disappear
- **Loading Indicator** - Shows progress while fetching
- **Error Handling** - Keeps existing data on load failure

### Pagination Flow
```
Page 1: [M1, M2, M3]
         ↓ (User scrolls)
Page 2: [M1, M2, M3, M4, M5, M6]
         ↓ (User scrolls)
Page 3: [M1, M2, M3, M4, M5, M6, M7, M8, M9]
```

### How Movies Are Preserved
```dart
// Spread operator merges old + new movies
final updatedMovies = [
  ...currentState.movies,  // [M1, M2, M3]
  ...response.results      // [M4, M5, M6]
];
// Result: [M1, M2, M3, M4, M5, M6]
```

## 🛠️ Technologies Used

### Core Dependencies
- **flutter_bloc** (^9.1.1) - State management with Cubit
- **dio** (^5.9.0) - HTTP client for API calls
- **hive_flutter** (^1.1.0) - Local database for caching
- **get_it** (^8.0.3) - Dependency injection
- **dartz** (^0.10.1) - Functional error handling
- **cached_network_image** (^3.4.1) - Image loading and caching

### Dev Dependencies
- **build_runner** (^2.4.13) - Code generation
- **hive_generator** (^2.0.1) - Generate Hive adapters

## 🔧 Setup Instructions

### Prerequisites
- Flutter SDK ^3.8.1
- TMDB API Key ([Get it here](https://www.themoviedb.org/settings/api))

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd movie_task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Add your TMDB API key**
   - Open `lib/core/constants/api_constants.dart`
   - Replace with your Bearer token:
   ```dart
   static const String bearerToken = 'YOUR_BEARER_TOKEN_HERE';
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Key Components

### Dependency Injection (GetIt)
```dart
// Service Locator setup
getIt.registerLazySingleton<Dio>(() => Dio());
getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
getIt.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(...));
getIt.registerFactory<MoviesCubit>(() => MoviesCubit(...));
```

### Error Handling (Dartz)
```dart
// Either<Failure, Success> pattern
final result = await repository.getPopularMovies(page: 1);
result.fold(
  (failure) => emit(MoviesError(message: failure.errorMessage)),
  (response) => emit(MoviesSuccess(movies: response.results)),
);
```

### Theme Management
```dart
// ThemeCubit with Hive persistence
ThemeCubit()
  ├── loadTheme() - Load saved theme on startup
  ├── toggleTheme() - Switch between light/dark
  └── Hive Box - Persist theme preference
```

## 🎯 Features Breakdown

### Caching Strategy
- ✅ Cache first 3 pages automatically
- ✅ Check cache before API call
- ✅ Fallback to cache on network error
- ✅ Clear cache option available

### Pagination Strategy
- ✅ Automatic scroll detection
- ✅ Load more at 90% scroll position
- ✅ Preserve existing movies
- ✅ Show loading indicator
- ✅ Handle errors gracefully

### Offline Support
- ✅ Works completely offline (cached pages)
- ✅ Shows stale data when refresh fails
- ✅ Smart fallback mechanism
- ✅ No data loss on errors

## 📚 Learning Resources

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
- [TMDB API Documentation](https://developers.themoviedb.org/3)

## 📝 License

This project is a learning exercise and is not intended for production use.

---

**Built with ❤️ using Flutter**
