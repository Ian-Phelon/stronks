import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/exercise_repository.dart'
    show ExerciseRepository;
import 'package:stronks/view/exercises/widgets/count_fine_popup.dart';
import 'package:stronks/view/exercises/widgets/widgets.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../widgets/widgets.dart';

/// Recieves a Map of all possible targets and combines them into their major
/// categories of Arms, Chest, Back, Core, and Legs.
///
/// arms[0], chest[1], back[2], core[3], legs[4]
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

/// Returns a Map based on Styles input. Accepts a null or empty input to return a default map with all values set to false.
Map<String, bool> _getStyleForView(BuildContext context, String? input) {
  return Provider.of<ExerciseRepository>(
    context,
    listen: false,
  ).eAspectForView(input: input == null || input == '' ? 'style' : input);
}

/// Returns a Map based on Equips input. Accepts a null or empty input to return a default map with all values set to false.
Map<String, bool> _getEquipForView(BuildContext context, String? input) {
  return Provider.of<ExerciseRepository>(
    context,
    listen: false,
  ).eAspectForView(input: input == null || input == '' ? 'equip' : input);
}

/// Returns a Map based on Target input. Accepts a null or empty input to return a default map with all values set to false.
Map<String, bool> _getTargetForView(BuildContext context, String? input) {
  return Provider.of<ExerciseRepository>(
    context,
    listen: false,
  ).eAspectForView(input: input == null || input == '' ? 'target' : input);
}

/// Provides a Size based on String length and Font Styling
Size _size(BuildContext context, String text) {
  text += '_____';
  return (TextPainter(
    text: TextSpan(text: text, style: kAspectTextStyle),
    maxLines: 1,
    textScaleFactor: MediaQuery.of(context).textScaleFactor,
    textDirection: TextDirection.ltr,
  )..layout())
      .size;
}

class CreateExerciseScreen extends StatefulWidget {
  const CreateExerciseScreen({Key? key}) : super(key: key);

  @override
  _CreateExerciseScreenState createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
  /// A set of boolean values to help determine if a part is selected, without
  /// assuming the equivalent part's values in targetFine
//////
  late bool addArms;
  late bool addChest;
  late bool addBack;
  late bool addCore;
  late bool addLegs;
///////
  /// The name of the exercise being made.
  /// can be left blank, or empty.
  final TextEditingController txtCtrl = TextEditingController();
  late int countForSets;
  StringBuffer targetStringBuilder = StringBuffer();
  StringBuffer stylesStringBuilder = StringBuffer();
  StringBuffer equipsStringBuilder = StringBuffer();
  late final Map<String, bool> styles;
  late final Map<String, bool> allTargets;
  late final Map<String, bool> equips;

  /// arms[0], chest[1], back[2], core[3], legs[4]
  late final List<Map<String, bool>> targetFine;

  /// Uses the index of ListView.builder to determine which Major Target Group has
  /// been selected by user
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

  /// Gets initialized with wether or not a Major Target Group has been
  /// selected. Is passed into the CreateExerciseFAB to handle wether or not
  /// user has selected any targetFine values.
  late List<bool> _targetFineSeletctions = [];

  void updateCountForSets(int i) {
    setState(() {
      countForSets = i;
    });
  }

  @override
  void initState() {
    /// When the screen is rebuilt, set all late values with user input using
    /// the top-level functions
    super.initState();

    countForSets = 0;

    if (_targetFineSeletctions.isEmpty) {
      addArms = false;
      addChest = false;
      addBack = false;
      addCore = false;
      addLegs = false;
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

    equipsStringBuilder.writeAll(_getEquipForView(
            super.context,
            equipsStringBuilder.length < 1
                ? 'equip'
                : equipsStringBuilder.toString())
        .entries
        .where((element) => element.value == true));

    styles = _getStyleForView(context, stylesStringBuilder.toString());

    equips = _getEquipForView(context, equipsStringBuilder.toString());

    allTargets = _getTargetForView(context, targetStringBuilder.toString());

    targetFine = _mapTargetFine(allTargets);
  }

  void setCountForSets(int i) {
    setState(() {
      countForSets = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TutorialBar tutorialBar = TutorialBar(
      pageContext: context,
    );

    return Scaffold(
      backgroundColor: colorExercisesBG,
      appBar: AppBar(
        title: Text('Create Exercise'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
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
                    itemCount: targetFine.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final Map<String, bool> specificTarget =
                          targetFine[index];

                      final MapEntry e1 = specificTarget.entries.elementAt(0);
                      final MapEntry e2 = specificTarget.entries.elementAt(1);
                      final MapEntry e3 = specificTarget.entries.elementAt(2);
                      final MapEntry e4 = specificTarget.entries.elementAt(3);

                      Size sizeFromText = _size(
                        context,
                        specificTarget.keys.first,
                      );

                      final MapEntry aspect = e1;
                      return Container(
                        height: sizeFromText.height,
                        width: _targetFineSeletctions[index] == true
                            ? sizeFromText.width + 58
                            : sizeFromText.width - 58,
                        child: AspectTile(
                          aspect: aspect,
                          mapTargetFine: specificTarget,
                          tapForSelection: () => _tapForTargetSelection(index),
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
                        Provider.of<ExerciseRepository>(context, listen: false)
                            .syleKeys[index],
                      );
                      return Container(
                        height: sizeFromText.height,
                        width: sizeFromText.width,
                        child: AspectTile(
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
                    itemCount: equips.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isSelected = equips.entries.elementAt(index).value;
                      MapEntry<String, bool> aspect =
                          equips.entries.elementAt(index);

                      Size sizeFromText = _size(
                        context,
                        Provider.of<ExerciseRepository>(context)
                            .equipKeys[index],
                      );
                      return Container(
                        width: sizeFromText.width,
                        height: sizeFromText.height,
                        child: AspectTile(
                            aspect: aspect,
                            tapForSelection: () {
                              setState(() {
                                String newEquipString =
                                    Provider.of<ExerciseRepository>(context,
                                            listen: false)
                                        .equipKeys
                                        .elementAt(index);
                                equips.update(
                                    newEquipString, (value) => !isSelected);

                                newEquipString += ', ';
                                if (equipsStringBuilder
                                        .toString()
                                        .contains(newEquipString) ==
                                    false)
                                  equipsStringBuilder.write(newEquipString);
                              });
                            },
                            isSelected: isSelected),
                      );
                    },
                  ),
                ),
              ),
              /////  Count For Sets. we need a counter row, where each callback sets the state of int countForSets
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => CountFinePopup(
                                onCounterChanged: setCountForSets,
                              ));
                    },
                    child: Text('$countForSets'),
                  ),
                  CounterRow(
                    countOne: () {
                      setCountForSets(1);
                    },
                    countFive: () {
                      setCountForSets(5);
                    },
                    countTen: () {
                      setCountForSets(10);
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      floatingActionButton: AddExerciseFAB(
        //  context,
        name: txtCtrl.text,
        countForSets: countForSets,
        style: styles,
        targetFine: targetFine,
        targetParts: _targetFineSeletctions,
        allTargets: allTargets,
        equips: equips,
      ),
    );
  }

  @override
  void dispose() {
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
    required this.equips,
  }) : super(key: key);
  final String name;
  final int countForSets;
  final Map<String, bool> style;
  final List<Map<String, bool>> targetFine;
  final List<bool> targetParts;
  final Map<String, bool> allTargets;
  final Map<String, bool> equips;
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
  }

  @override
  Widget build(BuildContext context) {
    String styleString = Provider.of<ExerciseRepository>(context, listen: false)
        .eAspectToStringBuilder(style);
    String targetString =
        Provider.of<ExerciseRepository>(context, listen: false)
            .eAspectToStringBuilder(allTargets);
    String equipString = Provider.of<ExerciseRepository>(context, listen: false)
        .eAspectToStringBuilder(equips);
    Map<String, dynamic> result = {
      'id': null,
      'name': '$name',
      'totalCount': 0,
      'countForSets': countForSets,
      'style': styleString,
      'targets': targetString,
      'equipment': equipString,
    };
    final repo = context.watch<ExerciseRepository>();
    void _addAndExit() {
      /// Necessary to update here instead of creating $result with the updated
      /// list, otherwise CreateExercises recognizes all targetFine as being
      /// selected.
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
