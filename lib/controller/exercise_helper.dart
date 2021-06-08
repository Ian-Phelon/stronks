// import '../model/model.dart' show Exercise;
import '../constants.dart';

/// methods to return parsed values for Exercise elements:
/// TODO: steps**:
///  TODO: notes
/// TEMPLATE: eElemenForView(), eElementFromUser()///
///
class ExerciseHelper {
  ExerciseHelper._();
  static final ExerciseHelper exerciseHelper = ExerciseHelper._();
  static final ExerciseKeys _keys = ExerciseKeys();
  factory ExerciseHelper() => exerciseHelper;

  /// facilitates visual representation by returning an Exercise's targets, equipment, and style with boolean values
  Map<String, bool> eAspectForView({required String aspect}) {
    var pattern = aspect.substring(0, 5);

    final Set<String> targetSet = _makeSet(exerciseAspect: aspect);
    List<String> listVariableAspect() {
      switch (pattern) {
        case r'target':
          return _keys.targets;
        case r'equip':
          return _keys.equip;
        case r'style':
          return _keys.style;
        case '':
          return _keys.none;
        default:
          return _keys.none;
      }
    }

    bool contains(String key) => targetSet.contains(key);

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
  /// helper method for this.eTargetsForView()
  Set<String> _makeSet({required String? exerciseAspect}) {
    Set<String> setFromView = {};
    exerciseAspect!.trim();
    setFromView.addAll(exerciseAspect.split(r', '));
    return setFromView;
  }

  ///  Storage only accepts a string, not a Map<String,bool>. eTargetsFromUser()
  /// provides a string for repo to store
  String eAspectFromUser(Map<String, bool> aspectFromUser) {
    var helper = StringBuffer();
    aspectFromUser.forEach((key, value) {
      value == true ? helper.write(key + ', ') : helper = helper;
    });
    return helper.toString();
  }
}

class ExerciseKeys {
  ExerciseKeys._();
  static final ExerciseKeys keys = ExerciseKeys._();
  factory ExerciseKeys() => keys;
  List<String> none = [
    '',
  ];
  List<String> targets = [
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
  List<String> equip = [
    kEquipBarbell,
    kEquipDumbell,
    kEquipMat,
    kEquipBand,
    kEquipMachineCardio,
    kEquipMachineStrength,
    kEquipBench,
    kEquipPullupBar,
    kEquipRaisedPlatform,
    kEquipWeight,
  ];
  List<String> style = [
    kStyleAerobic,
    kStyleAnaerobic,
    kStyleWarmup,
    kStyleStretch,
    kStyleStrength,
    kStyleIsometric,
    kStyleCardio,
  ];
}
