import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/core/di/service_locator.dart';
import 'package:movie_task/core/routing/router_app.dart';
import 'package:movie_task/core/routing/routes.dart';
import 'package:movie_task/core/theme/app_theme.dart';
import 'package:movie_task/core/theme/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetIt service locator (Hive, Dio, Repositories, etc.)
  await setupServiceLocator();

  runApp(const MovieTask());
}

class MovieTask extends StatelessWidget {
  const MovieTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Movie Task',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            onGenerateRoute: onGenerateRoute,
            initialRoute: Routes.home,
          );
        },
      ),
    );
  }
}
