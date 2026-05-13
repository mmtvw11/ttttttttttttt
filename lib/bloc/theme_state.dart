import 'package:equatable/equatable.dart';
import '../models/theme_model.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object?> get props => [];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

class ThemeChanged extends ThemeState {
  final ThemeModel themeModel;

  const ThemeChanged(this.themeModel);

  @override
  List<Object?> get props => [themeModel];
}
