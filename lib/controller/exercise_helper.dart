import '../constants.dart';

void main() {
  ExerciseHelper ok = ExerciseHelper();
  //Exercise me = ok.newExerciseAspects();
  print(ok.initializeAllAspects());
}

/// methods to return parsed values for Exercise elements
class ExerciseHelper {
  ExerciseHelper._();
  static final ExerciseHelper exerciseHelper = ExerciseHelper._();
  static final ExerciseKeys _keys = ExerciseKeys();
  factory ExerciseHelper() => exerciseHelper;

  /// facilitates visual representation by returning an Exercise's targets, equipment, and style with boolean values
  Map<String, bool> eAspectForView({required String aspect}) {
    final String pattern = aspect.length > 1 ? aspect.substring(0, 5) : '';

    final Set<String> aspectSet = _makeSet(exerciseAspect: aspect);

    List<String> listVariableAspect() {
      late final List<String> finalList;

      switch (pattern) {
        case r'target':
          finalList = _keys.targets;
          break;
        case r'equips':
          finalList = _keys.equip;
          break;
        case r'styles':
          finalList = _keys.style;
          break;

        default:
          finalList = _keys.none;
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
    exerciseAspect!.trim();
    setFromView.addAll(exerciseAspect.split(r', '));
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
    for (var e in ExerciseKeys.keys.targets) {
      final String key = e;
      targets[key] = false;
    }
    for (var e in ExerciseKeys.keys.equip) {
      final String key = e;

      equips[key] = false;
    }
    for (var e in ExerciseKeys.keys.style) {
      final String key = e;
      styles[key] = false;
    }
    newExercise.add(targets);
    newExercise.add(equips);
    newExercise.add(styles);
    return newExercise;
  }
}

class ExerciseKeys {
  ExerciseKeys._();
  static final ExerciseKeys keys = ExerciseKeys._();
  factory ExerciseKeys() => keys;
  final List<String> none = [];
  final List<String> targets = [
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
  final List<String> equip = [
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
  final List<String> style = [
    kStylesAerobic,
    kStylesAnaerobic,
    kStylesWarmup,
    kStylesStretch,
    kStylesStrength,
    kStylesIsometric,
    kStylesCardio,
  ];
}
