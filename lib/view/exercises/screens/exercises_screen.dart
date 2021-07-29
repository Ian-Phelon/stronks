import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/controller.dart'
    show ExerciseRepository, RoutePageManager, UserOptions;
import '../../../model/model.dart';
import '../widgets/widgets.dart'
    show ExerciseTile, RoundIconButton, CountFinePopupTotalCount;
import '../../widgets/widgets.dart' show MainBannerAd, TutorialBar;

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ExerciseRepository>(context).fetchAndSetExerciseTableData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Exercise List'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            _body(context),
            TutorialBar(pageContext: 'exercises'),
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

  final bool userRemovedAds =
      Provider.of<UserOptions>(context).getOptionValue(userOptionsIndex: 2);

  List<Exercise> repoList = repo.getExercises();
  return ListView.separated(
    padding: const EdgeInsets.only(bottom: 143),
    itemCount: repoList.length,
    separatorBuilder: (context, index) {
      if (index % 2 == 0)
        return userRemovedAds ? const SizedBox.shrink() : MainBannerAd();

      return const SizedBox.shrink();
    },
    itemBuilder: (context, index) {
      return ExerciseTile(
        exercise: repoList[index].id == repo.selectedExercise.id
            ? repo.selectedExercise
            : repoList[index],
        selectAndPushToEdit: () {
          var e = repoList[index];
          repo.selectExercise(e);

          RoutePageManager.of(context).toEditExerciseScreen();
        },
        quickCountPopup: () {
          repo.selectExercise(repoList[index]);
          var initialCount = repoList[index].totalCount!;
          showDialog(
            context: context,
            builder: (BuildContext context) => CountFinePopupTotalCount(
              exerciseName: repoList[index].name!,
              onCounterChanged: (v) {
                var e = repoList[index].copyWith(
                  totalCount: initialCount + v,
                );
                final List<bool> _targetFineSeletctions = [
                  repoList[index].targets!.contains('Arms'),
                  repoList[index].targets!.contains('Chest'),
                  repoList[index].targets!.contains('Back'),
                  repoList[index].targets!.contains('Core'),
                  repoList[index].targets!.contains('Legs'),
                ];
                print('QC TARGETS: ${e.targets}');
                repo.updateGeneral(e);
                var p = Performance(
                  id: null,
                  datePerformed: DateTime.now().toString(),
                  exerciseId: e.id,
                  updatedCount: v,
                  currentResistance: e.resistance,
                  currentTargets:
                      '${_targetFineSeletctions[0] ? 'arms ' : ''}${_targetFineSeletctions[1] ? 'chest ' : ''}${_targetFineSeletctions[2] ? 'back ' : ''}${_targetFineSeletctions[3] ? 'core ' : ''}${_targetFineSeletctions[4] ? 'legs ' : ''}',

                  ///This is where we need a function to parse the first integer
                  repsOrHold: e.countForSets,
                  splitMultiplier: 0,
                );
                print('QC PERFORMANCE: ${p.toString()}');
                repo.addPerformance(p.toMap());
              },
            ),
          );
        },
      );
    },
  );
}
