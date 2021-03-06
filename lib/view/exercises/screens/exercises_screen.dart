import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/controller.dart';
import '../../../model/model.dart';
import '../widgets/widgets.dart'
    show ExerciseTile, RoundIconButton, CountFinePopupTotalCount;
import '../../widgets/widgets.dart' show MainBannerAd, TutorialBar;

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  _ExercisesScreenState createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseRepository>(builder: (context, repo, _) {
      List<Exercise> repoList = repo.getExercises();
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Exercise List'),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Stack(
            children: [
              ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 55, 0, 143),
                  itemCount: repoList.length,
                  itemBuilder: (context, index) {
                    return ExerciseTile(
                      exercise: repoList[index],
                      selectAndPushToEdit: () {
                        var e = repoList[index];
                        repo.selectExercise(e);

                        RoutePageManager.of(context).toEditExerciseScreen();
                      },
                      quickCountPopup: () async {
                        repo.selectExercise(repoList[index]);
                        var initialCount = repoList[index].totalCount!;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CountFinePopupTotalCount(
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
                              StatsHelper.of(context).addPerformance(p.toMap());
                              repo.updateGeneral(e);
                              repoList = repo.getExercises();
                            },
                          ),
                        );
                      },
                    );
                  }),
              Align(
                alignment: Alignment.topCenter,
                child: MainBannerAd(),
              ),
              TutorialBar(pageContext: 'exercises'),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
    });
  }
}
