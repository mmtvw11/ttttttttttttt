import 'package:dio/dio.dart';
import '../models/weather_model.dart';

class WeatherService {
  static const String _apiKey = 'ed565d19b0014d75b03133642260605';
  static const String _baseUrl = 'https://api.weatherapi.com/v1';

  final Dio _dio = Dio();

  Future<WeatherModel> getWeatherByCity(String city) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'q': city,
          'appid': _apiKey,
          'units': 'metric', 
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Не удалось загрузить');
      }
    } catch (e) {
      throw Exception('Ошибка: $e');
    }
  }

  Future<WeatherModel> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Не удалось загрузить');
      }
    } catch (e) {
      throw Exception('Ошибка: $e');
    }
  }
}
