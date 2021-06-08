import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/exercise_repository.dart'
    show ExerciseRepository;
import 'package:stronks/view/exercises/widgets/widgets.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../widgets/widgets.dart';

class CreateExerciseScreen extends StatefulWidget {
  const CreateExerciseScreen({Key? key}) : super(key: key);

  @override
  _CreateExerciseScreenState createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
  int? countForSets;
  StringBuffer? targets;
  void setCountForSets(int i) {
    setState(() {
      countForSets = i;
    });
  }

  final TextEditingController txtCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ExerciseRepository>();
    final TutorialBar tutorialBar = TutorialBar(
      pageContext: context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Exercise'),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GradientBG(),
          tutorialBar,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: PurpleTextField(
                  keyboard: TextInputType.text,
                  onChanged: (value) => txtCtrl.text = value,
                  onSubmitted: (value) => txtCtrl.text = value,
                  // autofocus: true,
                ),
              ),
              //  TargetPanel(),
              // targetPanel,
            ],
          ),
        ],
      ),
      floatingActionButton: RoundTextButton(
        onPressed: () {
          //createdExercise.copyWith().name = txtCtrl.text;
          // createdExercise.bodyTargets = targetPanel.exercise.bodyTargets;
          Map<String, dynamic> result = {
            'name': '${txtCtrl.text}',
            'totalCount': 0,
            'countForSets': countForSets,
            //'targets': ,
          };
          // context.read<ExerciseRepository>()
          repo.addNewExercise(result);
          RoutePageManager.of(context).toExercises();
        },
        size: 42,
        text: 'Make It!',
        elevation: 4.0,
      ),
    );
  }

  @override
  void dispose() {
    this.txtCtrl.dispose();
    super.dispose();
  }
}
