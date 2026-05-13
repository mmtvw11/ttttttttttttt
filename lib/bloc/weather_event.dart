import 'package:equatable/equatable.dart';

// Событие для загрузки погоды
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeatherByCityEvent extends WeatherEvent {
  final String city;

  const FetchWeatherByCityEvent(this.city);

  @override
  List<Object?> get props => [city];
}

class FetchWeatherByCoordinatesEvent extends WeatherEvent {
  final double latitude;
  final double longitude;

  const FetchWeatherByCoordinatesEvent(
    this.latitude,
    this.longitude,
  );

  @override
  List<Object?> get props => [latitude, longitude];
}
