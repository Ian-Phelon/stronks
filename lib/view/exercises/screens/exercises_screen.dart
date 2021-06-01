import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../../model/model.dart';
import '../widgets/widgets.dart';
import '../../widgets/widgets.dart' show TutorialBar;

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final repoRead = context.read<ExerciseRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
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
  //final List<Exercise>? repoList =
  context.read<ExerciseRepository>().fetchAndSetData();
  final List<Exercise> repoList =
      context.watch<ExerciseRepository>().getExercises();
  final TutorialBar bar = TutorialBar(
    pageContext: context,
  );
  Widget _tile(BuildContext context, Exercise exercise) => ExerciseTile(
        exercise: exercise,
      );

  ///DEV PURPOSES ONLY, PLEASE DELETE
  final Widget yourBoat = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Expanded(child: bar),
      GestureDetector(
        child: TextButton(
          onPressed: () {
            context.read<ExerciseRepository>().deleteExerciseList();
          },
          child: Text('delete'),
        ),
      ),
    ],
  );

  return CustomScrollView(
    //shrinkWrap: true,
    slivers: [
      SliverToBoxAdapter(
        child: yourBoat,
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
            ); //tile.exercise = repoList[index];
            // return ExerciseTile(
            //   exercise: repoList[index],
            // );
          },
          childCount: repoList.isEmpty ? 1 : repoList.length,
          //repoList.isEmpty ? 1 : repoList.length,
        ),
      ),
    ],
  );
}
