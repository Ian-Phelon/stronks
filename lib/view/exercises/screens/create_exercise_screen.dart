import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/exercise_repository.dart'
    show ExerciseRepository;
import 'package:stronks/view/exercises/widgets/widgets.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../widgets/widgets.dart';

///  STARTING HERE, we need these methods, and under the big /// block are
///  experimental methods

Map<String, bool> _getStyleForView(BuildContext context, String? input) {
  return Provider.of<ExerciseRepository>(
    context,
    listen: false,
  ).eAspectForView(input: input == null || input == '' ? 'style' : input);
}

Map<String, bool> _getTargetForView(BuildContext context, String? input) {
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

//////////////////////////
//////////////////////////
//////////////////////////
//////////////////////////
//////////////////////////
//////////////////////////
//////////////////////////
//////////////////////////
//////////////////////////
//////////////////////////
//////////////////////////
/// provide string values for targetsFine in CreateExerciseScreen
Set<List<String>> _targetStrings(Map<String, bool> allTargets) {
  List<String> arms = [];
  List<String> chest = [];
  List<String> back = [];
  List<String> core = [];
  List<String> legs = [];
  for (var targets in allTargets.entries) {
    while (targets.key.startsWith(r'targetArms')) {
      arms.add(targets.key);
    }
    while (targets.key.startsWith(r'targetChest')) {
      chest.add(targets.key);
    }
    while (targets.key.startsWith(r'targetBack')) {
      back.add(targets.key);
    }
    while (targets.key.startsWith(r'targetCore')) {
      core.add(targets.key);
    }
    while (targets.key.startsWith(r'targetLegs')) {
      legs.add(targets.key);
    }
  }
  Set<List<String>> tToS = {arms, chest, back, core, legs};
  return tToS;
}

final List<Map<String, bool>> targetFine = [{}, {}, {}, {}, {}];

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
  late final Map<String, bool> styles = _getStyleForView(
      context,
      stylesStringBuilder.toString() == ''
          ? 'style'
          : stylesStringBuilder.toString());

  // late final Map<String, bool> allTargets =
  //     _targets(context, targetStringBuilder.toString());

  @override
  void initState() {
    super.initState();
    setState(
      () {
        stylesStringBuilder.writeAll(_getStyleForView(
                super.context,
                stylesStringBuilder.length < 1
                    ? 'style'
                    : stylesStringBuilder.toString())
            .entries
            .where((element) => element.value == true));
        targetStringBuilder.writeAll(_getTargetForView(
                super.context,
                targetStringBuilder.length < 1
                    ? 'target'
                    : targetStringBuilder.toString())
            .entries
            .where((element) => element.value == true));
      },
    );
    setState(() {
      final Map<String, bool> allTargets =
          _getStyleForView(context, targetStringBuilder.toString());
      for (var target in allTargets.entries) {
        var arms = target.key.startsWith(r'targetArms');
        var chest = target.key.startsWith(r'targetChest');
        var back = target.key.startsWith(r'targetBack');
        var core = target.key.startsWith(r'targetCore');
        var legs = target.key.startsWith(r'targetLegs');

        while (arms) {
          targetFine.elementAt(0).addAll({target.key: target.value});
          break;
        }
        while (chest) {
          targetFine.elementAt(1).addAll({target.key: target.value});
          break;
        }
        while (back) {
          targetFine.elementAt(2).addAll({target.key: target.value});
          break;
        }
        while (core) {
          targetFine.elementAt(3).addAll({target.key: target.value});
          break;
        }
        while (legs) {
          targetFine.elementAt(4).addAll({target.key: target.value});
          break;
        }
      }
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
        actions: [
          IconButton(
              onPressed: () {
                print('TARGET FINE: $targetFine \n STYLES: $styles');
              },
              icon: Icon(Icons.menu))
        ],
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
                      Size sizeFromText = _size(
                        context,
                        Provider.of<ExerciseRepository>(context)
                            .syleKeys[index],
                      );
                      return Container(
                        height: sizeFromText.height,
                        width: sizeFromText.width,
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: 99,
              //     child: ListView.builder(
              //       /////we dont want all targets, we want targetFine.
              //       itemCount: allTargets.length,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         bool isSelected =
              //             allTargets.entries.elementAt(index).value;
              //         /////////
              //         Size sizeFromText = _size(
              //           context,
              //           Provider.of<ExerciseRepository>(context)
              //               .targetKeys[index],
              //         );
              //         return Container(
              //           height: sizeFromText.height,
              //           width: isSelected
              //               ? sizeFromText.width * 1.2
              //               : sizeFromText.width,
              //           child: hehe(
              //             targetFine: {},
              //             isSelected: isSelected,
              //             aspect: allTargets.entries.elementAt(index),
              //             tapForSelection: () {
              //               setState(() {
              //                 String newTargetString =
              //                     Provider.of<ExerciseRepository>(context,
              //                             listen: false)
              //                         .targetKeys
              //                         .elementAt(index);
              //                 allTargets.update(
              //                     newTargetString, (value) => !isSelected);
              //                 // arms.update(key, (value) => false);
              //                 newTargetString += ', ';
              //                 if (targetStringBuilder
              //                         .toString()
              //                         .contains(newTargetString) ==
              //                     false)
              //                   targetStringBuilder.write(newTargetString);
              //               });
              //             },
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
            ],
          ),
        ],
      ),
      floatingActionButton:
          _pFAB(context, txtCtrl.text, countForSets, styles, {}),
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
  String name,
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
    'name': '$name',
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
