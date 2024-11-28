class WeatherModel {
  final String cityName;
  final double temperature;
  final int cloudiness;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.cloudiness,
  });

  // Factory pour convertir les données de l'API
  factory WeatherModel.fromApi(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      cloudiness: json['clouds']['all'],
    );
  }

  // Factory pour convertir les données de Firestore si nécessaire
  factory WeatherModel.fromFirestore(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['cityName'],
      temperature: json['temperature'].toDouble(),
      cloudiness: json['cloudiness'],
    );
  }

  // Convertir les données en format Firestore (si vous voulez les sauvegarder)
  Map<String, dynamic> toFirestore() {
    return {
      'cityName': cityName,
      'temperature': temperature,
      'cloudiness': cloudiness,
    };
  }
}
