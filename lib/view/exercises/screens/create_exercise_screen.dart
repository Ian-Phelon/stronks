import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show ReadContext;
import 'package:stronks/controller/exercise_repository.dart'
    show ExerciseRepository;
import 'package:stronks/view/exercises/widgets/widgets.dart';

import '../../../model/model.dart' show Exercise;
import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../widgets/widgets.dart' show TutorialBar, TargetPanel;

class CreateExerciseScreen extends StatelessWidget {
  const CreateExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController txtCtrl = TextEditingController();

    final TargetPanel targetPanel = TargetPanel(
      pageContext: context,
      // exercise: createdExercise,
    );
// var repoRead =
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Exercise'),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GradientBG(),
          TutorialBar(
            pageContext: context,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PurpleTextField(
                keyboard: TextInputType.text,
                onChanged: (value) => txtCtrl.text = value,
                onSubmitted: (value) => txtCtrl.text = value,
                // autofocus: true,
              ),
              //  TargetPanel(),
              targetPanel,
            ],
          ),
        ],
      ),
      floatingActionButton: RoundTextButton(
        onPressed: () {
          final Exercise createdExercise = Exercise().copyWith(
            name: txtCtrl.text,
          );
          // createdExercise.name = txtCtrl.text;
          // createdExercise.bodyTargets = targetPanel.exercise.bodyTargets;
          context.read<ExerciseRepository>().saveExercise(createdExercise);
          RoutePageManager.of(context).toExercises();
        },
        size: 42,
        text: 'Make It!',
        elevation: 4.0,
      ),
    );
  }
}

// PurpleTextField(
//   keyboard: TextInputType.text,
//   onChanged: (value) => txtCtrl.text = value,
//   onSubmitted: (value) => txtCtrl.text = value,
//   // autofocus: true,
// ),
