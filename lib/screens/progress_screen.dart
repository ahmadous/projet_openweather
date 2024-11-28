import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import '../services/firestore_service.dart';
import '../models/weather_model.dart';

class ProgressEvent {}

class ProgressState {
  final int progress; // En pourcentage
  final List<WeatherModel> weatherData; // Données récupérées
  final String message; // Message à afficher

  ProgressState(this.progress, this.weatherData, this.message);
}

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final WeatherApiService weatherApiService;

  final FirestoreService firestoreService;
  final List<String> cities = [
    'Dakar',
    'Thiès',
    'Kaolack',
    'Saint-Louis',
    'Tamba'
  ];

  Timer? _timer;
  int _progress = 0;

  ProgressBloc(this.firestoreService, {required this.weatherApiService})
      : super(ProgressState(0, [], 'Nous téléchargeons les données...')) {
    on<ProgressEvent>(_onProgress);
  }

  void _onProgress(ProgressEvent event, Emitter<ProgressState> emit) {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
        if (_progress < 100) {
          final cityIndex = (_progress ~/ 20); // Index de la ville
          final weather =
              await firestoreService.fetchWeather(cities[cityIndex]);
          final messages = [
            'Nous téléchargeons les données...',
            'C\'est presque fini...',
            'Plus que quelques secondes...'
          ];

          _progress += 20;
          emit(ProgressState(
            _progress,
            [...state.weatherData, weather],
            messages[(_progress ~/ 40).clamp(0, 2)],
          ));
        } else {
          _timer?.cancel();
          _timer = null;
        }
      });
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
