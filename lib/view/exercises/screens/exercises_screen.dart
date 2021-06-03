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
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
        actions: [
          IconButton(
              onPressed: () {
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
  context.read<ExerciseRepository>().fetchAndSetData();
  final List<Exercise> repoList =
      context.watch<ExerciseRepository>().getExercises();
  final TutorialBar bar = TutorialBar(
    pageContext: context,
  );
  Widget _tile(BuildContext context, Exercise exercise) =>
      ExerciseTile(exercise: exercise);

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
