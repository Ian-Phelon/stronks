import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/exercise_repository.dart'
    show ExerciseRepository;
import 'package:stronks/view/exercises/widgets/widgets.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../widgets/widgets.dart';

Map<String, bool> _style(BuildContext context, String? input) {
  return Provider.of<ExerciseRepository>(
    context,
    listen: false,
  ).eAspectForView(input: input == null || input == '' ? 'style' : input);
}

Map<String, bool> _targets(BuildContext context, String? input) {
  return Provider.of<ExerciseRepository>(
    context,
    listen: false,
  ).eAspectForView(input: input == null || input == '' ? 'target' : input);
}

Size _size(BuildContext context, String text) {
  text += '_____';
  return (TextPainter(
          text: TextSpan(text: text, style: kAspectTextStyle),
          maxLines: 1,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textDirection: TextDirection.ltr)
        ..layout())
      .size;
}

class CreateExerciseScreen extends StatefulWidget {
  const CreateExerciseScreen({Key? key}) : super(key: key);

  @override
  _CreateExerciseScreenState createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
  int? countForSets;
  StringBuffer targetStringBuilder = StringBuffer();
  StringBuffer stylesStringBuilder = StringBuffer();
  StringBuffer? equips;
  late final Map<String, bool> styles =
      _style(context, stylesStringBuilder.toString());

  late final Map<String, bool> targets =
      _targets(context, targetStringBuilder.toString());

  @override
  void initState() {
    super.initState();
    setState(
      () {
        stylesStringBuilder.writeAll(_style(
                super.context,
                stylesStringBuilder.length < 1
                    ? 'style'
                    : stylesStringBuilder.toString())
            .entries
            .where((element) => element.value == true));
        targetStringBuilder.writeAll(_style(
                super.context,
                targetStringBuilder.length < 1
                    ? 'target'
                    : targetStringBuilder.toString())
            .entries
            .where((element) => element.value == true));
      },
    );
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
          SizedBox(
            height: MediaQuery.of(context).size.height * .20,
          ),
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

              /////////////////////
              /////////////////////
              /////////////////////
              /////////////////////
              /////////////////////
              /////////////////////
              /////////////////////
              /////////////////////
              /////////////////////
              /////////////////////
              /////////////////////
              /////////////////////
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 99,
                  child: ListView.builder(
                    // addAutomaticKeepAlives: true,

                    itemCount: styles.length,
                    // itemExtent: 200,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isSelected = styles.entries.elementAt(index).value;
                      /////////
                      return Container(
                        height: _size(
                          context,
                          Provider.of<ExerciseRepository>(context)
                              .syleKeys[index],
                        ).height,
                        width: _size(
                          context,
                          Provider.of<ExerciseRepository>(context)
                              .syleKeys[index],
                        ).width,
                        child: haha(
                          // context: context,
                          isSelected: isSelected,
                          aspect: styles.entries.elementAt(index),
                          tapForSelection: () {
                            setState(() {
                              String newStyleString =
                                  Provider.of<ExerciseRepository>(context,
                                          listen: false)
                                      .syleKeys
                                      .elementAt(index);
                              styles.update(
                                  newStyleString, (value) => !isSelected);
                              newStyleString += ', ';
                              if (stylesStringBuilder
                                      .toString()
                                      .contains(newStyleString) ==
                                  false)
                                stylesStringBuilder.write(newStyleString);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
////////////////////////////
////////////////////////////
////////////////////////////
////////////////////////////
////////////////////////////
////////////////////////////
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 99,
                  child: ListView.builder(
                    // addAutomaticKeepAlives: true,

                    itemCount: targets.length,
                    // itemExtent: 200,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isSelected = targets.entries.elementAt(index).value;
                      /////////
                      ///targets.entries.elementAt(index)
                      return Container(
                        height: _size(
                          context,
                          Provider.of<ExerciseRepository>(context)
                              .targetKeys[index],
                        ).height,
                        width: _size(
                          context,
                          Provider.of<ExerciseRepository>(context)
                              .targetKeys[index],
                        ).width,
                        child: hehe(
                          // context: context,
                          targetFine: {},
                          isSelected: isSelected,
                          aspect: targets.entries.elementAt(index),
                          tapForSelection: () {
                            setState(() {
                              String newTargetString =
                                  Provider.of<ExerciseRepository>(context,
                                          listen: false)
                                      .targetKeys
                                      .elementAt(index);
                              targets.update(
                                  newTargetString, (value) => !isSelected);
                              newTargetString += ', ';
                              if (targetStringBuilder
                                      .toString()
                                      .contains(newTargetString) ==
                                  false)
                                targetStringBuilder.write(newTargetString);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton:
          _pFAB(context, txtCtrl.text, countForSets, styles, targets),
    );
  }

  @override
  void dispose() {
    this.txtCtrl.dispose();
    this.styles.clear();
    super.dispose();
  }
}

Widget _pFAB(
  BuildContext context,
  String text,
  int? countForSets,
  Map<String, bool> style,
  Map<String, bool> targets,
) {
  final String styleString =
      Provider.of<ExerciseRepository>(context).eAspectToStringBuilder(style);
  final String targetString =
      Provider.of<ExerciseRepository>(context).eAspectToStringBuilder(targets);
  final Map<String, dynamic> result = {
    'id': null,
    'name': '$text',
    'totalCount': 0,
    'countForSets': countForSets ?? 0,
    'style': styleString,
    'targets': targetString,
  };
  final repo = context.watch<ExerciseRepository>();
  return RoundTextButton(
    onPressed: () {
      repo.addToExerciseList(result);
      RoutePageManager.of(context).toExercises();
    },
    size: 42,
    text: 'Make It!',
    elevation: 4.0,
  );
}

Widget haha({
  required MapEntry<String, bool> aspect,
  required VoidCallback tapForSelection,
  required bool isSelected,
}) {
  return AspectTile(
    aspect: aspect,
    tapForSelection: tapForSelection,
    isSelected: isSelected,
  );
}

Widget hehe({
  required MapEntry aspect,
  required Map<String, bool> targetFine,
  required VoidCallback tapForSelection,
  required bool isSelected,
}) {
  return AspectTile(
    mapTargetFine: targetFine,
    aspect: aspect,
    tapForSelection: tapForSelection,
    isSelected: isSelected,
  );
}
