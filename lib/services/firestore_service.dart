import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/weather_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<WeatherModel> fetchWeather(String city) async {
    final snapshot = await _firestore.collection('weather').doc(city).get();
    final data = snapshot.data();
    return WeatherModel.fromFirestore(data!);
  }
}
