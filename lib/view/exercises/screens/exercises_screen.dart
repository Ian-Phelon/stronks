import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/controller.dart'
    show ExerciseRepository, RoutePageManager;
import '../../../model/model.dart';
import '../widgets/widgets.dart'
    show ExerciseTile, RoundIconButton, CountFinePopupTotalCount;
import '../../widgets/widgets.dart' show MainBannerAd, TutorialBar;

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Exercise List'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 44, 0, 0),
              child: _body(context),
            ),
            TutorialBar(pageContext: context),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: RoundIconButton(
          onTap: () {
            RoutePageManager.of(context).toCreateExerciseScreen();
          },
          icon: Icons.add,
          size: 120,
          elevation: 4.0,
        ),
      ),
    );
  }
}

Widget _body(BuildContext context) {
  final repo = context.watch<ExerciseRepository>();

  final List<Exercise> repoList = repo.getExercises();

  Widget _tile(BuildContext context, Exercise exercise) => ExerciseTile(
        exercise: exercise,
        selectAndPushToEdit: () {
          repo.selectExercise(exercise);
          RoutePageManager.of(context).toEditExerciseScreen();
        },
        quickCountPopup: () {
          var initialCount = exercise.totalCount!;
          showDialog(
            context: context,
            builder: (BuildContext context) => CountFinePopupTotalCount(
              ok: (v) => v,
              onCounterChanged: (v) {
                var e = exercise.copyWith(
                  totalCount: initialCount + v,
                );
                repo.updateGeneral(e);
                var p = Performance(
                  id: null,
                  datePerformed: DateTime.now().toString(),
                  exerciseId: e.id,
                  updatedCount: v,
                  currentResistance: e.resistance,

                  ///This is where we need a function to parse the first integer
                  repsOrHold: e.countForSets,
                  splitMultiplier: 0,
                );
                repo.addPerformance(p.toMap());
              },
            ),
          );
        },
      );
  return ListView.separated(
    padding: const EdgeInsets.only(bottom: 143),
    itemCount: repoList.length,
    separatorBuilder: (context, index) {
      if (index % 2 == 0) return MainBannerAd();

      return const SizedBox.shrink();
    },
    itemBuilder: (context, index) {
      return _tile(
        context,
        repoList[index],
      );
    },
  );
}
