import 'package:flutter/material.dart';
import 'package:stronks/controller/controller.dart';
import 'package:provider/provider.dart';

import '../../widgets/widgets.dart';
import '../../exercises/widgets/widgets.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ExerciseRepository>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Stats'),
        actions: [
          IconButton(
              onPressed: () {
                repo.dropDB();
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return CountFinePopupTotalCount(
                            onCounterChanged: (v) {},
                          );
                        });
                  },
                  child: Text('ok')),
              // CountFinePopupSets(onCounterChanged: (v) {}),
              MainBannerAd(),
              Text(
                'Total Exercise Count: ${repo.allExercisesTotalCount().toString()}',
                style: Theme.of(context).textTheme.headline5,
              ),
              const Divider(),
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
        ),
      ),
    );
  }
}
