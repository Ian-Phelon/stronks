import 'package:flutter/material.dart';

const colorPurpleDark = Color(0xff6654d1);
const colorPurpleLight = Color(0xff9286db);

const colorExercisesBG = Color(0xFFFF907C);
const colorExercisesBGOG = Color(0xffdd7b69);
const beer = Color(0xffFF583B);

const colorGradientBG = GradientBG();

///bloc example flutter_weather weather_populated.dart
class GradientBG extends StatelessWidget {
  const GradientBG();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.25, 0.75, 0.90, 1.0],
          colors: [
            colorExercisesBG,
            colorExercisesBG.desaturate(10),
            colorExercisesBG.saturate(33),
            colorExercisesBG.desaturate(50),
          ],
        ),
      ),
    );
  }
}

///bloc example flutter_weather weather_populated.dart
extension on Color {
  Color saturate([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }

  ///my 'addition' to the example
  Color desaturate([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red - ((255 - red) * p).round(),
      green - ((255 - green) * p).round(),
      blue - ((255 - blue) * p).round(),
    );
  }
}

class PurpleTextField extends TextField {
  const PurpleTextField({
    @required this.onChanged,
    @required this.onSubmitted,
    // @required this.autofocus,
    @required this.keyboard,
    // this.node
  }) : super(
          //  focusNode: node.canRequestFocus,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          cursorColor: Colors.purpleAccent,
          autofocus: true,
          decoration: const InputDecoration(
            hoverColor: Colors.purpleAccent,
          ),
        );

//   final FocusNode node;
  final Function(String)? onChanged;

  final Function(String)? onSubmitted;

  //final bool autofocus;

  final TextInputType? keyboard;
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Text(
        'OOPS',
        style: TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }
}
