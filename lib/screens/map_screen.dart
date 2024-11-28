import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final String city;

  MapScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    // Coordonnées fictives pour les villes
    final cityCoordinates = {
      'Dakar': LatLng(14.6928, -17.4467),
      'Thiès': LatLng(14.8059, -16.9255),
      'Kaolack': LatLng(14.1512, -16.0726),
      'Saint-Louis': LatLng(16.0179, -16.4896),
      'Tamba': LatLng(13.7675, -13.6673),
    };

    return Scaffold(
      appBar: AppBar(title: Text('Carte de $city')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: cityCoordinates[city]!,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: MarkerId(city),
            position: cityCoordinates[city]!,
            infoWindow: InfoWindow(title: city),
          ),
        },
      ),
    );
  }
}
