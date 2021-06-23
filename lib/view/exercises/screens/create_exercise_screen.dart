import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/exercise_repository.dart'
    show ExerciseRepository;
import 'package:stronks/view/exercises/widgets/widgets.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../widgets/widgets.dart';

MapEntry<String, bool> _changeMapValue(MapEntry<String, bool> entry) {
  MapEntry<String, bool> updatedEntry =
      MapEntry<String, bool>(entry.key, !entry.value);
  return updatedEntry;
}

List<Map<String, bool>> _mapTargetFine(Map<String, bool> allTargets) {
  List<Map<String, bool>> targetFine = [{}, {}, {}, {}, {}];
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
  return targetFine;
}

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

class CreateExerciseScreen extends StatefulWidget {
  const CreateExerciseScreen({Key? key}) : super(key: key);

  @override
  _CreateExerciseScreenState createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
//////
  bool? addArms;
  bool? addChest;
  bool? addBack;
  bool? addCore;
  bool? addLegs;
///////
  int? countForSets;
  StringBuffer targetStringBuilder = StringBuffer();
  StringBuffer stylesStringBuilder = StringBuffer();
  StringBuffer? equips;
  late final Map<String, bool> styles;

  late final Map<String, bool> allTargets;

  /// arms[0], chest[1], back[2], core[3], legs[4]
  late final List<Map<String, bool>> targetFine;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (addArms == null) addArms = false;
      if (addChest == null) addChest = false;
      if (addBack == null) addBack = false;
      if (addCore == null) addCore = false;
      if (addLegs == null) addLegs = false;
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
      styles = _getStyleForView(context, stylesStringBuilder.toString());
      allTargets = _getTargetForView(context, targetStringBuilder.toString());
      targetFine = _mapTargetFine(allTargets);
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
                debugPrint(
                    'ALL TARGETS: $allTargets \n TARGET FINE: $targetFine \n STYLES: $styles');
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
                      MapEntry<String, bool> aspect =
                          styles.entries.elementAt(index);

                      Size sizeFromText = _size(
                        context,
                        Provider.of<ExerciseRepository>(context)
                            .syleKeys[index],
                      );
                      return Container(
                        height: sizeFromText.height,
                        width: sizeFromText.width,
                        child: haha(
                          isSelected: isSelected,
                          aspect: aspect,
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
                              print(stylesStringBuilder);
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
                    itemCount: targetFine.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final Map<String, bool> specificTarget =
                          targetFine[index];

                      final MapEntry e1 = specificTarget.entries.elementAt(0);
                      final MapEntry e2 = specificTarget.entries.elementAt(1);
                      final MapEntry e3 = specificTarget.entries.elementAt(2);
                      final MapEntry e4 = specificTarget.entries.elementAt(3);

                      // bool isSelected =
                      //     specificTarget.values.any((e) => e == true);
                      final List<bool> targetFineSeletctions = [
                        addArms!,
                        addChest!,
                        addBack!,
                        addCore!,
                        addLegs!
                      ];
                      final Size sizeFromText = _size(
                        context,
                        specificTarget.keys.first,
                      );

                      final MapEntry aspect = targetFine[index].entries.first;

                      return Container(
                        height: sizeFromText.height,
                        width: sizeFromText.width,
                        child: hehe(
                          aspect: aspect,
                          targetFine: specificTarget,
                          tapForSelection: () {
                            setState(() {
                              if (index == 0) addArms = !addArms!;
                              if (index == 1) addChest = !addChest!;
                              if (index == 2) addBack = !addBack!;
                              if (index == 3) addCore = !addCore!;
                              if (index == 4) addLegs = !addLegs!;
                            });
                          },
                          isSelected: targetFineSeletctions[index],
                          updateInner: () {
                            String key = e1.key;
                            final bool isSelected = e1.value;
                            setState(() {
                              allTargets.update(key, (value) => !isSelected);
                              targetFine
                                  .elementAt(index)
                                  .update(key, (value) => !isSelected);
                              key += ', ';
                              if (targetStringBuilder
                                      .toString()
                                      .contains(key) ==
                                  false) targetStringBuilder.write(key);

                              print(targetStringBuilder);
                            });
                          },
                          updateOuter: () {
                            String key = e2.key;
                            final bool isSelected = e2.value;
                            setState(() {
                              allTargets.update(key, (value) => !isSelected);
                              targetFine
                                  .elementAt(index)
                                  .update(key, (value) => !isSelected);
                              key += ', ';
                              if (targetStringBuilder
                                      .toString()
                                      .contains(key) ==
                                  false) targetStringBuilder.write(key);

                              print(targetStringBuilder);
                            });
                          },
                          updateUpper: () {
                            String key = e3.key;
                            final bool isSelected = e3.value;
                            setState(() {
                              allTargets.update(key, (value) => !isSelected);
                              targetFine
                                  .elementAt(index)
                                  .update(key, (value) => !isSelected);
                              key += ', ';
                              if (targetStringBuilder
                                      .toString()
                                      .contains(key) ==
                                  false) targetStringBuilder.write(key);

                              print(targetStringBuilder);
                            });
                          },
                          updateLower: () {
                            String key = e4.key;
                            final bool isSelected = e4.value;
                            setState(() {
                              allTargets.update(key, (value) => !isSelected);
                              targetFine
                                  .elementAt(index)
                                  .update(key, (value) => !isSelected);
                              key += ', ';
                              if (targetStringBuilder
                                      .toString()
                                      .contains(key) ==
                                  false) targetStringBuilder.write(key);

                              print(targetStringBuilder);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              //////////////////////////////////////
              //////////////////////////////////////
              //////////////////////////////////////
            ],
          ),
        ],
      ),
      floatingActionButton:
          _pFAB(context, txtCtrl.text, countForSets, styles, allTargets),
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
  // required Function(Map<String, bool>, MapEntry<String, bool>) targetFineSelect,
}) {
  return AspectTile(
    aspect: aspect,
    tapForSelection: tapForSelection,
    isSelected: isSelected,
    // targetFineSelect: targetFineSelect,
  );
}

Widget hehe({
  required MapEntry aspect,
  required Map<String, bool> targetFine,
  required VoidCallback tapForSelection,
  required VoidCallback updateInner,
  required VoidCallback updateOuter,
  required VoidCallback updateUpper,
  required VoidCallback updateLower,
  required bool isSelected,
}) {
  return AspectTile(
    mapTargetFine: targetFine,
    aspect: aspect,
    tapForSelection: tapForSelection,
    isSelected: isSelected,
    // targetFineSelect: targetFineSelect,
    updateInner: updateInner,
    updateOuter: updateOuter,
    updateUpper: updateUpper,
    updateLower: updateLower,
  );
}
