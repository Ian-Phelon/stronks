import '../constants.dart';

/// methods to return parsed values for Exercise elements
class ExerciseHelper {
  const ExerciseHelper();

  static final ExerciseKeys keys = ExerciseKeys();

  /// facilitates visual representation by returning an Exercise's targets,
  /// equipment, and style with booleanvalues. Strings accetpted are
  /// 'target', 'equip, 'style'
  Map<String, bool> eAspectForView({required String aspect}) {
    // final String pattern = aspect.length > 1 ? aspect.substring(0, 5) : '';

    final Set<String> aspectSet = _makeSet(exerciseAspect: aspect);

    List<String> listVariableAspect() {
      late final List<String> finalList;

      switch (aspect) {
        case r'target':
          finalList = keys.targets;
          break;
        case r'equip':
          finalList = keys.equip;
          break;
        case r'style':
          finalList = keys.style;
          break;
        case r'none':

        default:
          finalList = keys.none;
          break;
      }
      return finalList;
    }

    bool contains(String key) => aspectSet.contains(key);

    Map<String, bool> parsedAspects = {};

    if (aspect != '') {
      for (var i = 0; i < listVariableAspect().length; i++) {
        String key = listVariableAspect()[i];
        bool targeted = contains(key);
        parsedAspects.addAll({key: targeted});
      }
    } else {
      for (var i = 0; i < listVariableAspect().length; i++) {
        String key = listVariableAspect()[i];
        parsedAspects.addAll({key: false});
      }
    }
    return parsedAspects;
  }

  //
  /// helper method for this.eAspectsForView()
  Set<String> _makeSet({required String? exerciseAspect}) {
    Set<String> setFromView = {};
    // exerciseAspect!.trim();
    setFromView.addAll(exerciseAspect!.split(r', '));
    return setFromView;
  }

  ///  Storage only accepts a string, not a Map<String,bool>. eAspectFromUser()
  /// provides a string for repo to store
  String eAspectToString(Map<String, bool> aspectFromUser) {
    var helper = StringBuffer();
    aspectFromUser.forEach((key, value) {
      value == true ? helper.write(key + ', ') : helper = helper;
    });
    return helper.toString();
  }

  /// List [0]:targets, [1]:equip, [2]:style
  List<Map<String, bool>> initializeAllAspects() {
    final List<Map<String, bool>> newExercise = [];
    final Map<String, bool> targets = {};
    final Map<String, bool> equips = {};
    final Map<String, bool> styles = {};
    for (var e in ExerciseKeys.ekeys.targets) {
      final String key = e;
      targets[key] = false;
    }
    for (var e in ExerciseKeys.ekeys.equip) {
      final String key = e;

      equips[key] = false;
    }
    for (var e in ExerciseKeys.ekeys.style) {
      final String key = e;
      styles[key] = false;
    }
    newExercise.add(targets);
    newExercise.add(equips);
    newExercise.add(styles);
    return newExercise;
  }
}

class ExerciseKeys extends ExerciseHelper {
  const ExerciseKeys._();
  static final ExerciseKeys ekeys = ExerciseKeys._();
  factory ExerciseKeys() => ekeys;
  final List<String> none = const [];
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
