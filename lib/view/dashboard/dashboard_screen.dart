import 'dart:math';
import 'package:flutter/material.dart';
import '../../controller/controller.dart';
import './widgets/widgets.dart';
import '../widgets/widgets.dart' show TutorialBar, MainBannerAd, CommonDrawer;

const List<String> encouragement = [
  'Keep it Up!',
  'Let\'s Go!',
  'Pump Those Numbers Up!'
];

final rng = Random();
String encourage() => encouragement[rng.nextInt(encouragement.length)];
final String theEncouragement = encourage();

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CommonDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(theEncouragement),
        ),
        body: Stack(
          children: [
            TutorialBar(
              pageContext: 'dash',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DashButton(
                  onPressed: () {
                    RoutePageManager.of(context).toExercises();
                  },
                  buttonText: 'Exercises',
                ),
                DashButton(
                  onPressed: () {
                    RoutePageManager.of(context).toStats();
                  },
                  buttonText: 'Stats',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainBannerAd(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
