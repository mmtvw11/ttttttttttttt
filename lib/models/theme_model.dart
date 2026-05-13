import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

enum AppTheme { light, dark }

class ThemeModel extends Equatable {
  final AppTheme theme;
  final String backgroundImage;
  final ThemeData themeData;

  const ThemeModel({
    required this.theme,
    required this.backgroundImage,
    required this.themeData,
  });

  factory ThemeModel.light() {
    return ThemeModel(
      theme: AppTheme.light,
      backgroundImage: 'assets/images/light_bg.jpg',
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
    );
  }

  factory ThemeModel.dark() {
    return ThemeModel(
      theme: AppTheme.dark,
      backgroundImage: 'assets/images/dark_bg.jpg',
      themeData: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
    );
  }

  String get themeName {
    return theme == AppTheme.light ? 'Светлая тема' : 'Тёмная тема';
  }

  @override
  List<Object?> get props => [theme, backgroundImage, themeData];
}
