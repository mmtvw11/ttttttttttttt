import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService _weatherService = WeatherService();

  WeatherBloc() : super(const WeatherInitial()) {
    on<FetchWeatherByCityEvent>(_onFetchWeatherByCity);
    on<FetchWeatherByCoordinatesEvent>(_onFetchWeatherByCoordinates);
  }

  Future<void> _onFetchWeatherByCity(
    FetchWeatherByCityEvent event,
    Emitter<WeatherState> emit,
  ) async {
   
    emit(const WeatherLoading());

    try {
      final weather = await _weatherService.getWeatherByCity(event.city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
  Future<void> _onFetchWeatherByCoordinates(
    FetchWeatherByCoordinatesEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());

    try {
      final weather = await _weatherService.getWeatherByCoordinates(
        event.latitude,
        event.longitude,
      );
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
