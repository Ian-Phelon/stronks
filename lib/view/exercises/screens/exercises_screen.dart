import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/controller.dart'
    show ExerciseRepository, RoutePageManager;
import '../../../model/model.dart';
import '../widgets/widgets.dart'
    show ExerciseTile, RoundIconButton, DeleteExercisePopup;
import '../../widgets/widgets.dart' show MainBannerAd, TutorialBar;

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<ExerciseRepository>().fetchAndSetData();
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 42, 0, 0),
            child: _body(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TutorialBar(pageContext: context),
          ),
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
    );
  }
}

Widget _body(BuildContext context) {
  final repo = context.watch<ExerciseRepository>();

  final List<Exercise> repoList = repo.getExercises();
  // final TutorialBar bar = TutorialBar(
  //   pageContext: context,
  // );
  Widget _tile(BuildContext context, Exercise exercise) => ExerciseTile(
        titleSize: repo.sizeFromText(context, exercise.name!),
        exercise: exercise,
        selectAndPush: () {
          repo.selectExercise(exercise);
          RoutePageManager.of(context).toEditExerciseScreen();
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
  return ListView.separated(
    itemCount: repoList.length,
    separatorBuilder: (context, index) {
      if (index % 4 == 0)
        return MainBannerAd();
      else
        return SizedBox.shrink();
    },
    itemBuilder: (context, index) {
      return _tile(
        context,
        repoList[index],
      );
    },
  );

  ///
  ///

  // return CustomScrollView(
  //   //shrinkWrap: true,
  //   slivers: [
  //     SliverToBoxAdapter(
  //       child: bar,
  //     ),
  //     SliverList(

  //       delegate: SliverChildBuilderDelegate(
  //         (_, index) {
  //           int adOffset = 4;
  //           int shiftIndex;
  //           if (repoList.isEmpty) {
  //             return Text('nowidgets');
  //           }
  //           if (index % adOffset == 0) {
  //             index = index + 1;
  //             return Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: MainBannerAd(),
  //             );
  //           }

  //           return _tile(
  //             context,
  //             repoList[index],
  //           );
  //         },
  //         childCount: repoList.isEmpty ? 1 : repoList.length,
  //         //repoList.isEmpty ? 1 : repoList.length,
  //       ),
  //     ),
  //   ],
  // );
}
