import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../bloc/theme_bloc.dart';
import '../bloc/theme_state.dart';
import '../widgets/app_drawer.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _searchWeather() {
    final city = _cityController.text.trim();
    if (city.isNotEmpty) {
      context.read<WeatherBloc>().add(FetchWeatherByCityEvent(city));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        String backgroundImage = 'assets/images/light_bg.jpg';
        if (themeState is ThemeChanged) {
          backgroundImage = themeState.themeModel.backgroundImage;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Weather App'),
            centerTitle: true,
            elevation: 0,
          ),
          drawer: const AppDrawer(),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              hintText: 'Введите название города',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.location_city),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onSubmitted: (_) => _searchWeather(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _searchWeather,
                          icon: const Icon(Icons.search),
                          label: const Text('Поиск'),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherInitial) {
                        return Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            'Введите название города для поиска погоды',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(1, 1),
                                      blurRadius: 3,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                          ),
                        );
                      } else if (state is WeatherLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is WeatherLoaded) {
                        final weather = state.weather;
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${weather.city}, ${weather.country}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${weather.temperature.toStringAsFixed(1)}°C',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                weather.description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              Text(
                                                'Ощущается: ${weather.feelsLike.toStringAsFixed(1)}°C',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(Icons.opacity,
                                              color: Colors.blue),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Влажность',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            '${weather.humidity}%',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Icon(Icons.air,
                                              color: Colors.cyan),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Ветер',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            '${weather.windSpeed.toStringAsFixed(1)} м/с',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Icon(Icons.compress,
                                              color: Colors.orange),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Давление',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            '${weather.pressure} hPa',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is WeatherError) {
                        return Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Ошибка загрузки',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
