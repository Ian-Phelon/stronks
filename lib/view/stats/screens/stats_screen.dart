import 'package:flutter/material.dart';
import 'package:stronks/controller/exercise_repository.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ExerciseRepository>();
    return Scaffold(
      backgroundColor: kcolorExercisesBG,
      appBar: AppBar(
        title: Text('Stats'),
        actions: [
          IconButton(
              onPressed: () {
                repo.dropDB();
              },
              icon: Icon(Icons.menu))
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total Count: ${repo.allExercisesTotalCount().toString()}'),
              Text('Arms: ${repo.allExercisesTotalCountArms().toString()}'),
              Text('Chest: ${repo.allExercisesTotalCountChest().toString()}'),
              Text('Back: ${repo.allExercisesTotalCountBack().toString()}'),
              Text('Core: ${repo.allExercisesTotalCountCore().toString()}'),
              Text('Legs: ${repo.allExercisesTotalCountLegs().toString()}'),
            ],
          ),
        ),
      ),
    );
  }
}
