import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import 'progress_event.dart';
import 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final WeatherApiService weatherApiService;
  final List<String> cities = [
    'Dakar',
    'Thiès',
    'Kaolack',
    'Saint-Louis',
    'Tamba'
  ];

  Timer? _timer;
  ProgressBloc({required this.weatherApiService}) : super(ProgressInitial()) {
    on<StartProgress>(_onStartProgress);
    on<ResetProgress>(_onResetProgress);
  }

  Future<void> _onStartProgress(
      StartProgress event, Emitter<ProgressState> emit) async {
    emit(ProgressLoading(0));
    List<Map<String, dynamic>> weatherData = [];

    for (int i = 0; i < cities.length; i++) {
      try {
        final data = await weatherApiService.fetchWeather(cities[i]);
        weatherData.add(data);
      } catch (e) {
        emit(ProgressError('Failed to fetch weather for ${cities[i]}'));
        return;
      }

      // Mise à jour de la progression
      int percentage = ((i + 1) / cities.length * 100).toInt();
      emit(ProgressLoading(percentage));

      await Future.delayed(
          Duration(seconds: 10)); // Simule l'attente entre les appels
    }

    emit(ProgressCompleted(weatherData));
  }

  void _onResetProgress(ResetProgress event, Emitter<ProgressState> emit) {
    // Réinitialiser l'état à l'état initial
    emit(ProgressInitial());
  }
}
