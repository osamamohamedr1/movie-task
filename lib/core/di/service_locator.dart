import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_task/core/networking/api_service.dart';
import 'package:movie_task/core/theme/cubit/theme_cubit.dart';
import 'package:movie_task/features/home/data/data_sources/movie_local_data_source.dart';
import 'package:movie_task/features/home/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_task/features/home/data/models/movie_model.dart';
import 'package:movie_task/features/home/data/models/movies_response.dart';
import 'package:movie_task/features/home/data/repos/movie_repository_impl.dart';
import 'package:movie_task/features/home/presentation/cubit/movies_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(MovieModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(MoviesResponseAdapter());
  }

  // Register Dio as singleton
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register ApiService as singleton
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  // Register Data Sources as singletons
  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(),
  );

  // Register Repository as singleton
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: getIt<MovieRemoteDataSource>(),
      localDataSource: getIt<MovieLocalDataSource>(),
    ),
  );

  // Register Cubit as factory (new instance each time)
  getIt.registerFactory<MoviesCubit>(
    () => MoviesCubit(movieRepository: getIt<MovieRepository>()),
  );

  // Register ThemeCubit as singleton
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // Initialize ThemeCubit
  await getIt<ThemeCubit>().init();
}
