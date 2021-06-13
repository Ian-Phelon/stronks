import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/exercise_repository.dart'
    show ExerciseRepository;
import 'package:stronks/view/exercises/widgets/widgets.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../widgets/widgets.dart';

List<String> USEME = [
  kStylesAerobic.characters.skip(kAspectStringSkip).toString(),
  kStylesAnaerobic.characters.skip(kAspectStringSkip).toString(),
  kStylesCardio.characters.skip(kAspectStringSkip).toString(),
  kStylesIsometric.characters.skip(kAspectStringSkip).toString(),
  kStylesStrength.characters.skip(kAspectStringSkip).toString(),
  kStylesStretch.characters.skip(kAspectStringSkip).toString(),
  kStylesWarmup.characters.skip(kAspectStringSkip).toString(),
];

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
    final TutorialBar tutorialBar = TutorialBar(
      pageContext: context,
    );

    return Scaffold(
      backgroundColor: colorExercisesBG,
      appBar: AppBar(
        title: Text('Create Exercise'),
      ),
      body: ListView(
        children: [
          tutorialBar,
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: PurpleTextField(
                  keyboard: TextInputType.text,
                  onChanged: (value) => txtCtrl.text = value,
                  onSubmitted: (value) => txtCtrl.text = value,
                ),
              ),
              Container(
                height: 99,
                child: ListView.builder(
                  addAutomaticKeepAlives: true,

                  itemCount: 7,
                  // itemExtent: 200,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return haha(
                      context: context,
                      title: USEME[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _pFAB(context, txtCtrl.text, countForSets),
    );
  }

  @override
  void dispose() {
    this.txtCtrl.dispose();
    super.dispose();
  }
}

Widget _pFAB(
  BuildContext context,
  String text,
  int? countForSets,
) {
  final repo = context.watch<ExerciseRepository>();
  return RoundTextButton(
    onPressed: () {
      Map<String, dynamic> result = {
        'name': '$text',
        'totalCount': 0,
        'countForSets': countForSets,
      };
      repo.addNewExercise(result);
      RoutePageManager.of(context).toExercises();
    },
    size: 42,
    text: 'Make It!',
    elevation: 4.0,
  );
}

Widget haha({
  required BuildContext context,
  required String title,
  required bool isSelected,
}) {
  return AspectTile(
    buildContext: context,
    title: title,
    isSelected: isSelected,
  );
}

Widget hehe({
  required BuildContext context,
  required String title,
  required bool isSelected,
}) {
  return AspectTile(
    buildContext: context,
    title: title,
    isTargets: {},
    isSelected: isSelected,
  );
}
