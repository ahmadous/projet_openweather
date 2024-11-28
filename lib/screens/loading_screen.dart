import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/progress_bloc.dart';
import '../blocs/progress_event.dart';
import '../blocs/progress_state.dart';
import 'result_screen.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Progress App',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: BlocConsumer<ProgressBloc, ProgressState>(
        listener: (context, state) {
          if (state is ProgressCompleted) {
            // Navigation vers un autre écran
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  weatherData: state.weatherData,
                ),
              ),
            );
          } else if (state is ProgressError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProgressInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ProgressBloc>().add(StartProgress());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                  'Commencer',
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            );
          } else if (state is ProgressLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: state.percentage / 100,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${state.percentage}%',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 18),
                  ),
                  (state.percentage > 0 && state.percentage <= 20)
                      ? Text("dakar est recupere")
                      : (state.percentage > 20 && state.percentage <= 40)
                          ? Text("Thies aussi ")
                          : (state.percentage > 40 && state.percentage <= 80)
                              ? Text("kaolack aussi")
                              : (state.percentage > 60 && state.percentage < 80)
                                  ? Text("saintlouis")
                                  : (state.percentage > 80 &&
                                          state.percentage < 100)
                                      ? Text("et Tamba maintenant")
                                      : Container()
                ],
              ),
            );
          } else if (state is ProgressError) {
            return Center(
              child: Text(
                'Erreur : ${state.message}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.red),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
