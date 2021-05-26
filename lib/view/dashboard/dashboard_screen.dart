import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../controller/controller.dart';
import 'widgets/widgets.dart';
import '../widgets/widgets.dart' show TutorialBar;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(super.runtimeType.toString()),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GradientBG(),
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
                  RoutePageManager.of(context).toCircuits();
                },
                buttonText: 'Circuits',
              ),
              DashButton(
                onPressed: () {
                  RoutePageManager.of(context).toStats();
                },
                buttonText: 'Stats',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // DashButton(
                  //   onPressed: () {
                  //     RoutePageManager.of(context).toTP();
                  //   },
                  //   buttonText: 'OTP',
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
            ],
          ),
          TutorialBar(
            pageContext: context,
          ),
        ],
      ),
    );
  }
}
