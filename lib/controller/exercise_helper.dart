import '../constants.dart';

/// methods to return parsed values for Exercise elements
class ExerciseHelper {
  const ExerciseHelper();

  static final ExerciseKeys keys = ExerciseKeys();

  static List<String> _listVariableAspect(String aspect) {
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

  /// facilitates visual representation by returning an Exercise's targets,
  /// equipment, and style with booleanvalues. Strings accetpted are
  /// 'target', 'equip, 'style'
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
  /// helper method for this.eAspectsForView()
  Set<String> _makeSet({required String? exerciseAspect}) {
    exerciseAspect?.trim();
    Set<String> setFromView = {};
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
  static final ExerciseKeys ekeys = ExerciseKeys._();
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
