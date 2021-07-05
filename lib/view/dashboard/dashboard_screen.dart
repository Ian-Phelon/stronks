import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../controller/controller.dart';
import 'widgets/widgets.dart';
import '../widgets/widgets.dart' show TutorialBar, MainBannerAd;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcolorExercisesBG,
      appBar: AppBar(
        title: Text(super.runtimeType.toString()),
      ),
      body: Stack(
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TutorialBar(
            pageContext: context,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MainBannerAd(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
