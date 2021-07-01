import '../constants.dart';

/// methods to return parsed values for Exercise elements
///
class ExerciseHelper {
  const ExerciseHelper();

  static final ExerciseKeys keys = ExerciseKeys();

  static List<String> _listVariableAspect(String aspect) {
    late final List<String> finalList;

    final bool isTargets = aspect.startsWith(r'target');
    final bool isEquips = aspect.startsWith(r'equip');
    final bool isStyle = aspect.startsWith(r'style');

    if (isTargets) {
      finalList = keys.targets;
    } else if (isEquips) {
      finalList = keys.equip;
    } else if (isStyle) {
      finalList = keys.style;
    } else {
      finalList = keys.none;
    }

    // switch (aspect) {
    //   case 'target':
    //     finalList = keys.targets;
    //     break;
    //   case 'equip':
    //     finalList = keys.equip;
    //     break;
    //   case 'style':
    //     finalList = keys.style;
    //     break;
    //   case 'none':

    //   default:
    //     finalList = keys.none;
    //     break;
    // }
    return finalList;
  }

  /// facilitates visual representation by returning an Exercise's targets,
  /// equipment, and style with boolean values. Strings accetpted for
  /// initializtion are 'target', 'equip, and 'style'; these will always return
  /// a map with keys that are all of the equivalent ExerciseKeys beginning with
  /// the initializtion string as well as all false values.
  ///
  /// Can also be given a comma separated string built elsewhere, which will
  /// return the map with true vaules where substrings included match their
  /// respective ExerciseKeys
  Map<String, bool> eAspectForView({required String aspect}) {
    final Set<String> aspectSet = _makeSet(exerciseAspect: aspect);
    bool contains(String key) => aspectSet.contains(key);
    final listForView = _listVariableAspect(aspect);

    Map<String, bool> parsedAspects = {};

    for (var i = 0; i < listForView.length; i++) {
      String key = listForView[i];
      bool value = contains(key);
      parsedAspects.addAll({key: value});
    }

    return parsedAspects;
  }

  //
  /// helper method for this.eAspectsForView() / creates an iterable to easily
  //separate values from the input string. / By comparing this set of strings to
  //a list of ExerciseKeys, we can / determine wether or not a value is true in
  //an entry output from eAspectsForView()
  Set<String> _makeSet({required String exerciseAspect}) {
    exerciseAspect.trim();
    Set<String> setFromView = {};
    setFromView.addAll(exerciseAspect.split(r', '));
    return setFromView;
  }

  ///  Storage only accepts a string, not a Map<String,bool>. eAspectUser()
  /// provides a string for repo to store
  String eAspectToString(Map<String, bool> aspectFromUser) {
    StringBuffer helper = StringBuffer();
    aspectFromUser.forEach((key, value) {
      value == true ? helper.write(key + ', ') : helper = helper;
    });
    return helper.toString();
  }

  Map<String, bool> initializeTargetAspects() {
    final Map<String, bool> targets = {};
    for (var e in ExerciseKeys.ekeys.targets) {
      final String key = e;
      targets[key] = false;
    }

    return targets;
  }
}

class ExerciseKeys extends ExerciseHelper {
  const ExerciseKeys._();
  static final ExerciseKeys ekeys = const ExerciseKeys._();
  factory ExerciseKeys() => ekeys;
  final List<String> none = const ['no aspect given'];
  final List<String> targets = const [
    kTargetArmsInner,
    kTargetArmsOuter,
    kTargetArmsUpper,
    kTargetArmsLower,
    kTargetChestInner,
    kTargetChestOuter,
    kTargetChestUpper,
    kTargetChestLower,
    kTargetBackInner,
    kTargetBackOuter,
    kTargetBackUpper,
    kTargetBackLower,
    kTargetCoreInner,
    kTargetCoreOuter,
    kTargetCoreUpper,
    kTargetCoreLower,
    kTargetLegsInner,
    kTargetLegsOuter,
    kTargetLegsUpper,
    kTargetLegsLower,
  ];
  final List<String> equip = const [
    kEquipsBarbell,
    kEquipsDumbell,
    kEquipsMat,
    kEquipsBand,
    kEquipsMachineCardio,
    kEquipsMachineStrength,
    kEquipsBench,
    kEquipsPullupBar,
    kEquipsRaisedPlatform,
    kEquipsWeight,
  ];
  final List<String> style = const [
    kStylesAerobic,
    kStylesAnaerobic,
    kStylesWarmup,
    kStylesStretch,
    kStylesStrength,
    kStylesIsometric,
    kStylesCardio,
  ];
}
