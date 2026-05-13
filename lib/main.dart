import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/weather_bloc.dart';
import 'bloc/theme_bloc.dart';
import 'bloc/theme_event.dart';
import 'bloc/theme_state.dart';
import 'screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          ThemeData themeData = ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          );

          if (state is ThemeChanged) {
            themeData = state.themeModel.themeData;
          }

          return MaterialApp(
            title: 'Weather App',
            theme: themeData,
            home: const WeatherScreen(),
          );
        },
      ),
    );
  }
}
