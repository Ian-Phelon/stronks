import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/controller.dart';

import '../widgets/widgets.dart';
import '../../../constants.dart';
import '../../widgets/widgets.dart' show TutorialBar, TargetPanel, CounterRow;

class EditExerciseScreen extends StatefulWidget {
  const EditExerciseScreen({
    Key? key,
  }) : super(key: key);

  @override
  _EditExerciseScreenState createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  final TextEditingController txtCtrl = TextEditingController();
  late bool editNameVisibility;

  @override
  void initState() {
    super.initState();
    setState(() {
      editNameVisibility = false;
    });
  }

  void _triggerVisibility() {
    setState(() {
      editNameVisibility = !editNameVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    final repoWatch = context.watch<ExerciseRepository>();
    // final repoRead = context.read<ExerciseRepository>();
    final exercise = repoWatch.selectedExercise!;
    final TargetPanel targetPanel = TargetPanel(
      pageContext: context,
      exercise: exercise,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('${exercise.name}'),
      ),
      body: GestureDetector(
        onTap: () {},
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GradientBG(),
            TutorialBar(
              pageContext: context,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        '${exercise.name}',
                      ),
                      RoundIconButton(
                        size: 12.0,
                        icon: Icons.edit,
                        onPressed: () => _triggerVisibility(),
                        elevation: 4.0,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  replacement: const SizedBox.shrink(),
                  visible: editNameVisibility,
                  child: PurpleTextField(
                    keyboard: TextInputType.text,
                    // autofocus: true,
                    onChanged: (value) {
                      txtCtrl.text = value;
                    },
                    onSubmitted: (value) {
                      repoWatch.updateSelectedExerciseName(txtCtrl.text);
                      _triggerVisibility();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        '${exercise.totalCount}',
                        style: TextStyle(fontSize: 26),
                      ),
                      RoundIconButton(
                        size: 12.0,
                        icon: Icons.add,
                        onPressed: () {
                          repoWatch.incrementExerciseCount(exercise, 1);
                        },
                        elevation: 4.0,
                      ),
                      CounterRow(countOne: () {
                        repoWatch.incrementExerciseCount(exercise, 1);
                      }, countFive: () {
                        repoWatch.incrementExerciseCount(exercise, 5);
                      }, countTen: () {
                        repoWatch.incrementExerciseCount(exercise, 10);
                      })
                    ],
                  ),
                ),
                // targetPanel,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
