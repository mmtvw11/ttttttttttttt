import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/theme_model.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeChanged(ThemeModel.light())) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetLightThemeEvent>(_onSetLightTheme);
    on<SetDarkThemeEvent>(_onSetDarkTheme);
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final currentState = state;
    if (currentState is ThemeChanged) {
      final newTheme = currentState.themeModel.theme == AppTheme.light
          ? ThemeModel.dark()
          : ThemeModel.light();
      emit(ThemeChanged(newTheme));
    }
  }

  Future<void> _onSetLightTheme(
    SetLightThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeChanged(ThemeModel.light()));
  }

  Future<void> _onSetDarkTheme(
    SetDarkThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeChanged(ThemeModel.dark()));
  }
}
