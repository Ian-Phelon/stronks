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
  TutorialBar bar = TutorialBar(
    pageContext: context,
  );

  ///DEV PURPOSES ONLY, PLEASE DELETE
  Row yourBoat = Row(
    children: [
      bar,
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
  List<int> okok = [
    0,
    1,
  ];
  return ListView.builder(
    itemBuilder:

        ///TODO: NEEDS AN ACTUAL LIST TO BUILD FROM
        (_, ok) {
      if (ok == 0) {
        return Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: bar,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('noWidgets'),
            )
          ],
        );
      }
      return CustomScrollView(
        slivers: [
          /// replace  yourBoat with bar, delete yourBoat
          SliverToBoxAdapter(child: yourBoat),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ExerciseTile(
                  //  exercise: box.(index),
                  ),
              // ..exercise?.index = index,
              childCount: okok.length,
            ),
          ),
        ],
      );
    },
  );
}
