import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_openwether_map/blocs/progress_event.dart';
import '../blocs/progress_bloc.dart';

class ResultScreen extends StatelessWidget {
  final List<dynamic> weatherData;

  ResultScreen({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résultats météo'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: weatherData.length,
              itemBuilder: (context, index) {
                final cityData = weatherData[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.location_city,
                        color: Theme.of(context).primaryColor),
                    title: Text(cityData['name']),
                    subtitle: Text(
                        'Température : ${(cityData['main']['temp'] - 273.15).toStringAsFixed(1)}°C\nNuages : ${cityData['clouds']['all']}%'),
                  ),
                );
              },
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     context
          //         .read<ProgressBloc>()
          //         .add(ResetProgress()); // Réinitialise le bloc
          //     Navigator.pop(context); // Retourne à l'écran précédent
          //   },
          //   child: Text('Recommencer'),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Theme.of(context).primaryColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}
