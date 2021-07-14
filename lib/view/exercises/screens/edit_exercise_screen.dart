import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/controller.dart'
    show ExerciseRepository, RoutePageManager;
import 'package:stronks/view/exercises/widgets/count_fine_popup.dart';

import '../widgets/widgets.dart' show RoundIconButton;
import '../../widgets/widgets.dart'
    show AspectTile, CounterRow, MainBannerAd, StronksTextButton, TutorialBar;
import '../../../model/model.dart' show Exercise;

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

  late Exercise exercise;

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
  void initState() {
    super.initState();
    editNameVisibility = false;
    var repo = Provider.of<ExerciseRepository>(
      context,
      listen: false,
    );
    exercise = repo.selectedExercise!;
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
  }

  @override
  void dispose() {
    nameTxtCtrl.dispose();
    notesTxtCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ExerciseRepository>();
    var exerciseView = repo.selectedExercise!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${repo.selectedExercise!.name}'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                var newTargets = _newTargets();
                Exercise ex = repo.selectedExercise!
                    .copyWith(targets: repo.eAspectToStringBuilder(newTargets));
                repo.updateGeneral(ex);
                RoutePageManager.of(context).toExercises();
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          TutorialBar(
            pageContext: context,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => CountFinePopup(
                            whichCount: exerciseView.totalCount!,
                            onCounterChanged: (count) {
                              count += exercise.totalCount!;
                              var e = exercise.copyWith(
                                totalCount: count,
                              );
                              repo.updateGeneral(e);
                            },
                          ));
                },
                child: Text(
                  '${repo.selectedExercise!.totalCount}',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  '${repo.selectedExercise!.name} Total Count',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainBannerAd(),
              ),
              Padding(
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
                      replacement: GestureDetector(
                        onTap: _triggerNoteFieldVisibility,
                        child: Text(
                          '${initialNotesCtrl.text}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: null,
                        autofocus: true,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: initialNotesCtrl,
                        onChanged: (v) {
                          notesTxtCtrl.text = v;
                          var e =
                              exerciseView.copyWith(notes: notesTxtCtrl.text);
                          repo.updateGeneral(e);
                        },
                        onSubmitted: (v) {
                          notesTxtCtrl.text = v;
                          var e =
                              exerciseView.copyWith(notes: notesTxtCtrl.text);
                          repo.updateGeneral(e);
                          _triggerNoteFieldVisibility();
                        },
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
                      builder: (_) => CountFinePopup(
                            whichCount: exerciseView.resistance!,
                            onCounterChanged: (count) {
                              count += exerciseView.resistance!;
                              var e = exerciseView.copyWith(
                                resistance: count,
                              );
                              repo.updateGeneral(e);
                            },
                          ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Resistance: ${exerciseView.resistance == 0 ? 'n/a' : exerciseView.resistance}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              StronksTextButton(
                text: 'Targets',
                onTap: () {
                  _triggerTargetVisibility();
                },
              ),
              Visibility(
                replacement: const SizedBox(
                  height: 18.0,
                ),
                visible: editTargetVisibility,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: targetFine.length,
                        itemBuilder: (context, index) {
                          final Map<String, bool> specificTarget =
                              targetFine[index];
                          final MapEntry e1 =
                              specificTarget.entries.elementAt(0);
                          final MapEntry e2 =
                              specificTarget.entries.elementAt(1);
                          final MapEntry e3 =
                              specificTarget.entries.elementAt(2);
                          final MapEntry e4 =
                              specificTarget.entries.elementAt(3);

                          final MapEntry aspect = e1;

                          Exercise eToSubmit;
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
                              tapForSelection: () =>
                                  _tapForTargetSelection(index),
                              mapTargetFine: specificTarget,
                              updateInner: () {
                                String thisKey = e1.key;
                                final bool isSelected = e1.value;
                                allTargets.update(
                                    thisKey, (value) => !isSelected);
                                targetFine
                                    .elementAt(index)
                                    .update(thisKey, (value) => !isSelected);
                                eToSubmit = repo.selectedExercise!.copyWith(
                                    targets: repo
                                        .eAspectToStringBuilder(allTargets));
                                repo.updateGeneral(eToSubmit);
                              },
                              updateOuter: () {
                                String thisKey = e2.key;
                                final bool isSelected = e2.value;
                                allTargets.update(
                                    thisKey, (value) => !isSelected);
                                targetFine
                                    .elementAt(index)
                                    .update(thisKey, (value) => !isSelected);
                                eToSubmit = repo.selectedExercise!.copyWith(
                                    targets: repo
                                        .eAspectToStringBuilder(allTargets));
                                repo.updateGeneral(eToSubmit);
                              },
                              updateUpper: () {
                                String thisKey = e3.key;
                                final bool isSelected = e3.value;
                                allTargets.update(
                                    thisKey, (value) => !isSelected);
                                targetFine
                                    .elementAt(index)
                                    .update(thisKey, (value) => !isSelected);
                                eToSubmit = repo.selectedExercise!.copyWith(
                                    targets: repo
                                        .eAspectToStringBuilder(allTargets));
                                repo.updateGeneral(eToSubmit);
                              },
                              updateLower: () {
                                String thisKey = e4.key;
                                final bool isSelected = e4.value;
                                allTargets.update(
                                    thisKey, (value) => !isSelected);
                                targetFine
                                    .elementAt(index)
                                    .update(thisKey, (value) => !isSelected);
                                eToSubmit = repo.selectedExercise!.copyWith(
                                    targets: repo
                                        .eAspectToStringBuilder(allTargets));
                                repo.updateGeneral(eToSubmit);
                              },
                            ),
                          );
                        }),
                  ),
                ),
              ),
              StronksTextButton(
                  text: 'Style',
                  onTap: () {
                    _triggerStyleVisibility();
                  }),
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
                        bool isSelected = styles.entries.elementAt(index).value;
                        MapEntry<String, bool> aspect =
                            styles.entries.elementAt(index);

                        Size sizeFromText = repo.sizeFromText(
                          context,
                          Provider.of<ExerciseRepository>(context,
                                  listen: false)
                              .syleKeys[index],
                        );
                        Exercise eToSubmit;
                        return Container(
                          height: sizeFromText.height,
                          width: sizeFromText.width,
                          child: AspectTile(
                            isSelected: isSelected,
                            aspect: aspect,
                            tapForSelection: () {
                              String newStyleString =
                                  Provider.of<ExerciseRepository>(context,
                                          listen: false)
                                      .syleKeys
                                      .elementAt(index);
                              styles.update(
                                  newStyleString, (value) => !isSelected);
                              eToSubmit = exerciseView.copyWith(
                                  style: repo.eAspectToStringBuilder(styles));
                              repo.updateGeneral(eToSubmit);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              StronksTextButton(
                  text: 'Equipment',
                  onTap: () {
                    _triggerEquipVisibility();
                  }),
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
                        bool isSelected = equips.entries.elementAt(index).value;
                        MapEntry<String, bool> aspect =
                            equips.entries.elementAt(index);

                        Size sizeFromText = repo.sizeFromText(
                          context,
                          Provider.of<ExerciseRepository>(context)
                              .equipKeys[index],
                        );
                        Exercise eToSubmit;
                        return Container(
                          width: sizeFromText.width,
                          height: sizeFromText.height,
                          child: AspectTile(
                              aspect: aspect,
                              tapForSelection: () {
                                // setState(() {
                                String newEquipString =
                                    Provider.of<ExerciseRepository>(context,
                                            listen: false)
                                        .equipKeys
                                        .elementAt(index);
                                equips.update(
                                    newEquipString, (value) => !isSelected);
                                eToSubmit = exerciseView.copyWith(
                                    equipment:
                                        repo.eAspectToStringBuilder(equips));
                                repo.updateGeneral(eToSubmit);

                                // });
                              },
                              isSelected: isSelected),
                        );
                      },
                    ),
                  ),
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
                      '${repo.selectedExercise!.name}',
                      style: Theme.of(context).textTheme.headline6,
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
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline6,
                  onChanged: (value) => nameTxtCtrl.text = value,
                  onSubmitted: (value) {
                    var e = exercise.copyWith(name: nameTxtCtrl.text);
                    repo.updateGeneral(e);
                    _triggerNameVisibility();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
