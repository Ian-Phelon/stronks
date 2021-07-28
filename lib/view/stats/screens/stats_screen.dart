import 'package:flutter/material.dart';
import 'package:stronks/controller/controller.dart';
import 'package:provider/provider.dart';

import '../../widgets/widgets.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ExerciseRepository>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Stats'),
        ),
        body: Stack(
          children: [
            TutorialBar(pageContext: context),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainBannerAd(),
                Text(
                  'Total Exercise Count: ${repo.allExercisesTotalCount().toString()}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onBackground,
                  indent: 8.0,
                  endIndent: 8.0,
                ),
                Text(
                  'Arm Exercises: ${repo.allExercisesTotalCountArms().toString()}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Chest Exercises: ${repo.allExercisesTotalCountChest().toString()}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Back Exercises: ${repo.allExercisesTotalCountBack().toString()}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Core Exercises: ${repo.allExercisesTotalCountCore().toString()}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Leg Exercises: ${repo.allExercisesTotalCountLegs().toString()}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                MainBannerAd(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
