import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/progress_bloc.dart';
import 'services/api_service.dart';
import 'screens/loading_screen.dart';

void main() {
  final weatherApiService = WeatherApiService(
    baseUrl: 'https://api.openweathermap.org/data/2.5',
    apiKey: 'a31c68f733379c36c8b33d6c8688df08',
  );

  runApp(MyApp(weatherApiService: weatherApiService));
}

class MyApp extends StatelessWidget {
  final WeatherApiService weatherApiService;

  const MyApp({required this.weatherApiService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1E88E5), // Bleu
        hintColor: Color(0xFFFF6F00), // Orange
        scaffoldBackgroundColor: Color(0xFFFFFFFF), // Blanc
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF1E88E5), // Bouton bleu
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
              color: Color(0xFF1E88E5),
              fontWeight: FontWeight.bold,
              fontSize: 24),
          bodyLarge: TextStyle(color: Color(0xFF000000), fontSize: 16),
          bodyMedium: TextStyle(color: Color(0xFF666666), fontSize: 14),
        ),
      ),
      // Définit LoadingScreen comme écran principal
      home: BlocProvider(
        create: (_) => ProgressBloc(weatherApiService: weatherApiService),
        child: LoadingScreen(),
      ),
    );
  }
}
