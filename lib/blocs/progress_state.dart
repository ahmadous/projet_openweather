// blocs/progress_state.dart
abstract class ProgressState {}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {
  final int percentage;

  ProgressLoading(this.percentage);
}

class ProgressCompleted extends ProgressState {
  final List<Map<String, dynamic>> weatherData;

  ProgressCompleted(this.weatherData);
}

class ProgressError extends ProgressState {
  final String message;

  ProgressError(this.message);
}
