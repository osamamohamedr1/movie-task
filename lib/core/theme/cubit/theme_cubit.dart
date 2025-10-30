import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  final String themeModeKey = 'themeMode';
  final String kLight = 'light';
  final String kDark = 'dark';
  final String kSystem = 'system';

  late Box box;

  Future<void> init() async {
    box = await Hive.openBox('themeBox');
    loadTheme();
  }

  void loadTheme() {
    final currentThemeMode = box.get(themeModeKey);
    if (currentThemeMode != null) {
      if (currentThemeMode == kLight) {
        emit(ThemeMode.light);
      } else if (currentThemeMode == kDark) {
        emit(ThemeMode.dark);
      } else {
        emit(ThemeMode.system);
      }
    } else {
      emit(ThemeMode.light);
    }
  }

  void toggleTheme() async {
    final newTheme = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(newTheme);
    await box.put(themeModeKey, newTheme == ThemeMode.light ? kLight : kDark);
  }
}
