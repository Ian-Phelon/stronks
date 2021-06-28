import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart'
    show ExerciseRepository, RoutePageManager;
import '../../../model/model.dart';
import '../widgets/widgets.dart'
    show ExerciseTile, RoundIconButton, DeleteExercisePopup;
import '../../widgets/widgets.dart' show TutorialBar;

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<ExerciseRepository>().fetchAndSetData();
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
        actions: [
          IconButton(
              onPressed: () {
                /// TODO: delete dev print
                final ok = context.read<ExerciseRepository>().getExercises();
                print(ok.toString());
              },
              icon: Icon(Icons.menu))
        ],
      ),
      backgroundColor: colorExercisesBG,
      body: _body(context),
      floatingActionButton: RoundIconButton(
        onPressed: () {
          RoutePageManager.of(context).toCreateExerciseScreen();
        },
        icon: Icons.add,
        size: 80,
        elevation: 4.0,
      ),
    );
  }
}

Widget _body(BuildContext context) {
  final repo = context.watch<ExerciseRepository>();

  final List<Exercise> repoList = repo.getExercises();
  final TutorialBar bar = TutorialBar(
    pageContext: context,
  );
  Widget _tile(BuildContext context, Exercise exercise) => ExerciseTile(
        exercise: exercise,
        selectAndPush: () {
          repo.selectExercise(exercise);
          RoutePageManager.of(context).toEditExerciseScreen(exercise);
        },
        deleteExercise: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                DeleteExercisePopup(deleteExerciseAndTile: () {
              Navigator.pop(context);
              repo.removeExerciseFromDB(exercise);
            }),
          );
        },
      );

  ///
  ///

  return CustomScrollView(
    //shrinkWrap: true,
    slivers: [
      SliverToBoxAdapter(
        child: bar,
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            if (repoList.isEmpty) {
              return Text('nowidgets');
            }
            return _tile(
              context,
              repoList[index],
            );
          },
          childCount: repoList.isEmpty ? 1 : repoList.length,
          //repoList.isEmpty ? 1 : repoList.length,
        ),
      ),
    ],
  );
}
