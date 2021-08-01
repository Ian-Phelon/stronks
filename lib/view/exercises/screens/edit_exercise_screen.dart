import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/controller.dart';
import 'package:stronks/view/exercises/widgets/count_fine_popup.dart';

import '../widgets/widgets.dart' show DeleteExercisePopup, RoundIconButton;
import '../../widgets/widgets.dart'
    show AspectTile, MainBannerAd, StronksTextButton, TutorialBar;
import '../../../model/model.dart';

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

class EditExerciseScreen extends StatefulWidget {
  const EditExerciseScreen({
    Key? key,
  }) : super(key: key);

  @override
  _EditExerciseScreenState createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  final TextEditingController nameTxtCtrl = TextEditingController();
  final TextEditingController notesTxtCtrl = TextEditingController();
  late final TextEditingController initialNotesCtrl;
  late String initialNotes;
  late int countForResistance;

  late bool editNameVisibility;
  bool editTargetVisibility = false;
  bool editStyleVisibility = false;
  bool editEquipVisibility = false;
  bool editNoteFieldVisibility = false;

  late bool addArms;
  late bool addChest;
  late bool addBack;
  late bool addCore;
  late bool addLegs;
  late List<bool> _targetFineSeletctions = [];
  late Map<String, bool> styles;
  late Map<String, bool> allTargets;
  late Map<String, bool> equips;

  /// arms[0], chest[1], back[2], core[3], legs[4]
  late List<Map<String, bool>> targetFine;

  /// used as a control variable since we cant access context outside of
  /// initState or build methods
  late Exercise exercise;

  void _tapForTargetSelection(int index) {
    if (index == 0) addArms = !addArms;
    if (index == 1) addChest = !addChest;
    if (index == 2) addBack = !addBack;
    if (index == 3) addCore = !addCore;
    if (index == 4) addLegs = !addLegs;
    _targetFineSeletctions = [addArms, addChest, addBack, addCore, addLegs];
  }

  void _triggerNameVisibility() {
    setState(() {
      editNameVisibility = !editNameVisibility;
    });
  }

  void _triggerTargetVisibility() {
    setState(() {
      editTargetVisibility = !editTargetVisibility;
    });
  }

  void _triggerStyleVisibility() {
    setState(() {
      editStyleVisibility = !editStyleVisibility;
    });
  }

  void _triggerEquipVisibility() {
    setState(() {
      editEquipVisibility = !editEquipVisibility;
    });
  }

  void _triggerNoteFieldVisibility() {
    setState(() {
      editNoteFieldVisibility = !editNoteFieldVisibility;
    });
  }

  Map<String, bool> _newTargets() {
    Map<String, bool> checkedForValues = {};
    for (var i = 0; i < 5; i++) {
      bool emptyFine = targetFine[i].entries.every((e) => e.value == false) &&
          _targetFineSeletctions[i] == true;

      bool emptyTarget = targetFine[i].entries.every((e) => e.value == true) &&
          _targetFineSeletctions[i] == false;
      if (emptyFine) {
        targetFine[i].updateAll((key, value) => true);
        checkedForValues.addAll(targetFine[i]);
      } else if (emptyTarget) {
        targetFine[i].updateAll((key, value) => false);
        checkedForValues.addAll(targetFine[i]);
      } else {
        checkedForValues.addAll(targetFine[i]);
      }
    }
    return checkedForValues;
  }

  @override
  void didChangeDependencies() {
    ExerciseRepository.of(context).fetchAndSetExerciseTableData();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    var repo = ExerciseRepository.of(context);
    editNameVisibility = false;
    exercise = repo.selectedExercise;
    countForResistance = exercise.resistance!;
    initialNotes = exercise.notes.toString();
    bool emptyNotes = initialNotes == '';
    initialNotesCtrl =
        TextEditingController(text: emptyNotes ? 'Add a Note' : initialNotes);
    notesTxtCtrl.addListener(() {
      notesTxtCtrl.value = notesTxtCtrl.value.copyWith(
        selection: TextSelection(
            baseOffset: initialNotes.length, extentOffset: initialNotes.length),
        // composing: TextRange.,
      );
    });
    styles = repo.eAspectForView(
        input: exercise.style == null || exercise.style == ''
            ? 'style'
            : exercise.style);
    allTargets = repo.eAspectForView(
        input: exercise.targets == null || exercise.targets == ''
            ? 'target'
            : exercise.targets!);
    equips = repo.eAspectForView(
        input: exercise.equipment == null || exercise.equipment == ''
            ? 'equip'
            : exercise.equipment);
    targetFine = _mapTargetFine(allTargets);
    if (_targetFineSeletctions.isEmpty) {
      addArms = targetFine[0].values.any((e) => e == true);
      addChest = targetFine[1].values.any((e) => e == true);
      addBack = targetFine[2].values.any((e) => e == true);
      addCore = targetFine[3].values.any((e) => e == true);
      addLegs = targetFine[4].values.any((e) => e == true);
    }
    _targetFineSeletctions = [addArms, addChest, addBack, addCore, addLegs];
    // super.initState();
  }

  @override
  void dispose() {
    nameTxtCtrl.dispose();
    notesTxtCtrl.dispose();
    initialNotesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ExerciseRepository.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${repo.selectedExercise.name}'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView(
          children: [
            TutorialBar(
              pageContext: 'editExercise',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => CountFinePopupTotalCount(
                              exerciseName: repo.selectedExercise.name!,
                              onCounterChanged: (count) {
                                int baseCount = count;
                                count += repo.selectedExercise.totalCount!;
                                var e = repo.selectedExercise.copyWith(
                                  totalCount: count,
                                );
                                print('EEQC TARGETS: ${e.targets}');
                                repo.updateGeneral(e);
                                var p = Performance(
                                  id: null,
                                  datePerformed: DateTime.now().toString(),
                                  exerciseId: e.id,
                                  updatedCount: baseCount,
                                  currentResistance: e.resistance,
                                  currentTargets:
                                      '${_targetFineSeletctions[0] ? 'arms ' : ''}${_targetFineSeletctions[1] ? 'chest ' : ''}${_targetFineSeletctions[2] ? 'back ' : ''}${_targetFineSeletctions[3] ? 'core ' : ''}${_targetFineSeletctions[4] ? 'legs ' : ''}',

                                  ///This is where we need a function to parse the first integer
                                  repsOrHold: e.countForSets,
                                  splitMultiplier: 0,
                                );
                                Provider.of<StatsHelper>(context, listen: false)
                                    .addPerformance(p.toMap());
                                // repo.addPerformance(p.toMap());

                                print('EEQC PERFORMANCE: ${p.toString()}');
                                // repo.selectExercise(e);
                              },
                            ));
                  },
                  child: Text(
                    '${repo.selectedExercise.totalCount}',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    '${repo.selectedExercise.name} Total Count',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainBannerAd(),
                ),
                GestureDetector(
                  onTap: () {
                    _triggerNoteFieldVisibility();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                          color: editNoteFieldVisibility
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.onBackground,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Visibility(
                          visible: editNoteFieldVisibility,
                          replacement: Text(
                            '${initialNotesCtrl.text}',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ),
                            style: Theme.of(context).textTheme.headline6,
                            maxLines: null,
                            autofocus: true,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            controller: initialNotesCtrl,
                            onChanged: (v) {
                              notesTxtCtrl.text = v;
                              // var e = repo.selectedExercise
                              //     .copyWith(notes: notesTxtCtrl.text);
                              // repo.updateGeneral(e);
                            },
                            onSubmitted: (v) {
                              notesTxtCtrl.text = v;
                              var e = repo.selectedExercise
                                  .copyWith(notes: notesTxtCtrl.text);
                              repo.updateGeneral(e);
                              _triggerNoteFieldVisibility();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => CountFinePopupResistance(
                              exerciseName: repo.selectedExercise.name!,
                              onCounterChanged: (count) {
                                var e = repo.selectedExercise.copyWith(
                                  resistance: count,
                                );

                                repo.updateGeneral(e);
                              },
                            ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Resistance: ${repo.selectedExercise.resistance == 0 ? 'n/a' : repo.selectedExercise.resistance} ${repo.selectedExercise.resistance == 0 ? '' : Provider.of<UserOptions>(context).getUserResistanceValue()}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => CountFinePopupSets(
                              exerciseName: repo.selectedExercise.name!,
                              onCounterChanged: (count) {
                                var e = repo.selectedExercise.copyWith(
                                  countForSets: count,
                                );
                                repo.updateGeneral(e);
                                // repo.selectExercise(e);
                              },
                            ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Reps in a Set: ${repo.selectedExercise.countForSets == 0 ? 'n/a' : repo.selectedExercise.countForSets}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: MainBannerAd(),
                ),
                StronksTextButton(
                  text: editTargetVisibility ? 'Update' : 'Targets',
                  onTap: () {
                    if (editTargetVisibility) {
                      var e = repo.selectedExercise.copyWith(
                          targets: repo.eAspectToStringBuilder(_newTargets()));
                      // repo.selectExercise(e);
                      repo.updateGeneral(e);
                    }

                    _triggerTargetVisibility();
                  },
                  isSelected: editTargetVisibility,
                ),
                Visibility(
                  replacement: const SizedBox(
                    height: 18.0,
                  ),
                  visible: editTargetVisibility,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: targetFine.length,
                          itemBuilder: (context, index) {
                            final Map<String, bool> specificTarget =
                                targetFine[index];
                            final MapEntry<String, bool> e1 =
                                specificTarget.entries.elementAt(0);
                            final MapEntry<String, bool> e2 =
                                specificTarget.entries.elementAt(1);
                            final MapEntry<String, bool> e3 =
                                specificTarget.entries.elementAt(2);
                            final MapEntry<String, bool> e4 =
                                specificTarget.entries.elementAt(3);

                            final MapEntry<String, bool> aspect = e1;

                            Size sizeFromText = repo.sizeFromText(
                              context,
                              specificTarget.keys.first,
                            );
                            return Container(
                              height: sizeFromText.height,
                              width: _targetFineSeletctions[index] == true
                                  ? sizeFromText.width + 58
                                  : sizeFromText.width - 58,
                              child: AspectTile(
                                aspect: aspect,
                                isSelected: _targetFineSeletctions[index],
                                tapForSelection: () {
                                  setState(() {
                                    _tapForTargetSelection(index);
                                    if (_targetFineSeletctions[index] == false)
                                      targetFine[index]
                                          .updateAll((key, value) => false);
                                  });
                                },
                                mapTargetFine: specificTarget,
                                updateInner: () {
                                  setState(() {
                                    String thisKey = e1.key;
                                    final bool isSelected = e1.value;
                                    allTargets.update(
                                        thisKey, (value) => !isSelected);
                                    targetFine.elementAt(index).update(
                                        thisKey, (value) => !isSelected);
                                  });
                                },
                                updateOuter: () {
                                  setState(() {
                                    String thisKey = e2.key;
                                    final bool isSelected = e2.value;
                                    allTargets.update(
                                        thisKey, (value) => !isSelected);
                                    targetFine.elementAt(index).update(
                                        thisKey, (value) => !isSelected);
                                  });
                                },
                                updateUpper: () {
                                  setState(() {
                                    String thisKey = e3.key;
                                    final bool isSelected = e3.value;
                                    allTargets.update(
                                        thisKey, (value) => !isSelected);
                                    targetFine.elementAt(index).update(
                                        thisKey, (value) => !isSelected);
                                  });
                                },
                                updateLower: () {
                                  setState(() {
                                    String thisKey = e4.key;
                                    final bool isSelected = e4.value;
                                    allTargets.update(
                                        thisKey, (value) => !isSelected);
                                    targetFine.elementAt(index).update(
                                        thisKey, (value) => !isSelected);
                                  });
                                },
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                StronksTextButton(
                  text: editStyleVisibility ? 'Update' : 'Style',
                  onTap: () {
                    var e = repo.selectedExercise
                        .copyWith(style: repo.eAspectToStringBuilder(styles));
                    // repo.selectExercise(e);
                    if (editStyleVisibility) {
                      repo.updateGeneral(e);
                    }
                    _triggerStyleVisibility();
                  },
                  isSelected: editStyleVisibility,
                ),
                Visibility(
                  replacement: const SizedBox(
                    height: 18.0,
                  ),
                  visible: editStyleVisibility,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 99,
                      child: ListView.builder(
                        itemCount: styles.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          bool isSelected =
                              styles.entries.elementAt(index).value;
                          MapEntry<String, bool> aspect =
                              styles.entries.elementAt(index);

                          Size sizeFromText = repo.sizeFromText(
                            context,
                            Provider.of<ExerciseRepository>(context,
                                    listen: false)
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
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                StronksTextButton(
                  text: editEquipVisibility ? 'Update' : 'Equipment',
                  onTap: () {
                    var e = repo.selectedExercise.copyWith(
                        equipment: repo.eAspectToStringBuilder(equips));
                    if (editEquipVisibility) {
                      repo.updateGeneral(e);
                      // repo.selectExercise(e);
                    }
                    _triggerEquipVisibility();
                  },
                  isSelected: editEquipVisibility,
                ),
                Visibility(
                  replacement: const SizedBox(
                    height: 18.0,
                  ),
                  visible: editEquipVisibility,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 99,
                      child: ListView.builder(
                        itemCount: equips.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          bool isSelected =
                              equips.entries.elementAt(index).value;
                          MapEntry<String, bool> aspect =
                              equips.entries.elementAt(index);

                          Size sizeFromText = repo.sizeFromText(
                            context,
                            Provider.of<ExerciseRepository>(context,
                                    listen: false)
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
                                  });
                                },
                                isSelected: isSelected),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                MainBannerAd(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RoundIconButton(
                          icon: Icons.delete_forever,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => DeleteExercisePopup(
                                      deleteExerciseAndTile: () {
                                        repo.removeExerciseFromDB(
                                            repo.selectedExercise);
                                        RoutePageManager.of(context)
                                            .toExercises();
                                      },
                                    ));
                          }),
                      Flexible(
                        flex: 16,
                        child: Text(
                          '${repo.selectedExercise.name}',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      RoundIconButton(
                          icon: Icons.edit,
                          onTap: () {
                            _triggerNameVisibility();
                          }),
                    ],
                  ),
                ),
                Visibility(
                  replacement: const SizedBox.shrink(),
                  visible: editNameVisibility,
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                      onChanged: (value) => nameTxtCtrl.text = value,
                      onSubmitted: (value) {
                        setState(() {
                          var e = exercise.copyWith(name: nameTxtCtrl.text);
                          repo.updateGeneral(e);
                          _triggerNameVisibility();
                        });
                      },
                    ),
                  ),
                ),
                MainBannerAd(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
