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
  late bool addArms;
  late bool addChest;
  late bool addBack;
  late bool addCore;
  late bool addLegs;
///////
  final TextEditingController txtCtrl = TextEditingController();
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
    // setState(() {
    if (_targetFineSeletctions.isEmpty) {
      addArms = false;
      addChest = false;
      addBack = false;
      addCore = false;
      addLegs = false;
      _targetFineSeletctions = [addArms, addChest, addBack, addCore, addLegs];
    }
    _targetFineSeletctions = [addArms, addChest, addBack, addCore, addLegs];
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
    // });
  }

  void _tapForTargetSelection(int index) {
    setState(() {
      if (index == 0) addArms = !addArms;
      if (index == 1) addChest = !addChest;
      if (index == 2) addBack = !addBack;
      if (index == 3) addCore = !addCore;
      if (index == 4) addLegs = !addLegs;
      _targetFineSeletctions = [addArms, addChest, addBack, addCore, addLegs];
    });
  }

  late List<bool> _targetFineSeletctions = [];

  // void _tapTargetSpecific(int index, String key, bool value) {}
  // Map<String, bool> _getTargetSpecific(){}
  // MapEntry<String,bool> _getTargetSpecificEntry()
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

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 99,
                  child: ListView.builder(
                    itemCount: styles.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isSelected = styles.entries.elementAt(index).value;
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
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
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

                      final List<bool> targetFineSeletctions =
                          _targetFineSeletctions;
                      //  = [
                      //   addArms,
                      //   addChest,
                      //   addBack,
                      //   addCore,
                      //   addLegs
                      // ];

                      Size sizeFromText = _size(
                        context,
                        specificTarget.keys.first,
                      );

                      final MapEntry aspect = targetFine[index].entries.first;
                      return Container(
                        height: sizeFromText.height,
                        width: targetFineSeletctions[index] == true
                            ? sizeFromText.width + 58
                            : sizeFromText.width - 58,
                        child: hehe(
                          aspect: aspect,
                          targetFine: specificTarget,
                          tapForSelection: () {
                            _tapForTargetSelection(index);
                          },
                          isSelected: _targetFineSeletctions[index],
                          updateInner: () {
                            String thisKey = e1.key;
                            final bool isSelected = e1.value;
                            setState(() {
                              allTargets.update(
                                  thisKey, (value) => !isSelected);
                              targetFine
                                  .elementAt(index)
                                  .update(thisKey, (value) => !isSelected);

                              thisKey += ', ';
                              if (targetStringBuilder
                                      .toString()
                                      .contains(thisKey) ==
                                  false) targetStringBuilder.write(thisKey);
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
      floatingActionButton: AddExerciseFAB(
        //  context,
        name: txtCtrl.text,
        countForSets: 0,
        style: styles,
        targetFine: targetFine,
        targetParts: _targetFineSeletctions,
        allTargets: allTargets,
      ),
    );
  }

  @override
  void dispose() {
    this.txtCtrl.dispose();
    this.styles.clear();
    this.allTargets.clear();

    super.dispose();
  }
}

class AddExerciseFAB extends StatelessWidget {
  const AddExerciseFAB({
    Key? key,
    required this.name,
    this.countForSets = 0,
    required this.style,
    required this.targetFine,
    required this.targetParts,
    required this.allTargets,
  }) : super(key: key);
  final String name;
  final int countForSets;
  final Map<String, bool> style;
  final List<Map<String, bool>> targetFine;
  final List<bool> targetParts;
  final Map<String, bool> allTargets;
  // BuildContext context;

  Map<String, bool> _newTargets() {
    Map<String, bool> checkedForValues = {};
    print('$targetParts');
    for (var i = 0; i < 5; i++) {
      bool emptyFine = targetFine[i].entries.every((e) => e.value == false) &&
          targetParts[i] == true;
      if (emptyFine) {
        targetFine[i].updateAll((key, value) => true);
        checkedForValues.addAll(targetFine[i]);
      } else {
        checkedForValues.addAll(targetFine[i]);
      }
    }
    return checkedForValues;
    // debugPrint('$allTargets');
    // return allTargets;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, bool> getTargets() => _newTargets();
    String styleString =
        Provider.of<ExerciseRepository>(context).eAspectToStringBuilder(style);
    String targetString = Provider.of<ExerciseRepository>(context)
        .eAspectToStringBuilder(allTargets);
    Map<String, dynamic> result = {
      'id': null,
      'name': '$name',
      'totalCount': 0,
      'countForSets': countForSets,
      'style': styleString,
      'targets': targetString,
    };
    final repo = context.watch<ExerciseRepository>();
    void _addAndExit() {
      result.update(
          'targets',
          (value) => Provider.of<ExerciseRepository>(context, listen: false)
              .eAspectToStringBuilder(_newTargets()));
      repo.addToExerciseList(result);
      RoutePageManager.of(context).toExercises();
    }

    return RoundTextButton(
      onPressed: () => _addAndExit(),
      size: 42,
      text: 'Make It!',
      elevation: 4.0,
    );
  }
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
