import 'package:flutter/material.dart';

/// Easy member access for a lot of common strings
const String kTargetArmsInner = 'targetArmsInner';
const String kTargetArmsOuter = 'targetArmsOuter';
const String kTargetArmsUpper = 'targetArmsUpper';
const String kTargetArmsLower = 'targetArmsLower';
const String kTargetChestInner = 'targetChestInner';
const String kTargetChestOuter = 'targetChestOuter';
const String kTargetChestUpper = 'targetChestUpper';
const String kTargetChestLower = 'targetChestLower';
const String kTargetBackInner = 'targetBackInner';
const String kTargetBackOuter = 'targetBackOuter';
const String kTargetBackUpper = 'targetBackUpper';
const String kTargetBackLower = 'targetBackLower';
const String kTargetCoreInner = 'targetCoreInner';
const String kTargetCoreOuter = 'targetCoreOuter';
const String kTargetCoreUpper = 'targetCoreUpper';
const String kTargetCoreLower = 'targetCoreLower';
const String kTargetLegsInner = 'targetLegsInner';
const String kTargetLegsOuter = 'targetLegsOuter';
const String kTargetLegsUpper = 'targetLegsUpper';
const String kTargetLegsLower = 'targetLegsLower';
const String kEquipsBarbell = 'equipsBarbell';
const String kEquipsDumbell = 'equipsDumbell';
const String kEquipsMat = 'equipsMat';
const String kEquipsBand = 'equipsBand';
const String kEquipsMachineCardio = 'equipsMachineCardio';
const String kEquipsMachineStrength = 'equipsMachineStrength';
const String kEquipsBench = 'equipsBench';
const String kEquipsPullupBar = 'equipsPullupBar';
const String kEquipsRaisedPlatform = 'equipsRaisedPlatform';
const String kEquipsWeight = 'equipsWeight';
const String kStylesAerobic = 'stylesAerobic';
const String kStylesAnaerobic = 'stylesAnaerobic';
const String kStylesWarmup = 'stylesWarmup';
const String kStylesStretch = 'stylesStretch';
const String kStylesStrength = 'stylesStrength';
const String kStylesIsometric = 'stylesIsometric';
const String kStylesCardio = 'stylesCardio';

const String kEquipsMachineCardioToText = 'Cardio Machine';
const String kEquipsMachineStrengthToText = 'Strength Machine';
const String kEquipsPullupBarToText = 'Pullup Bar';
const String kEquipsRaisedPlatformToText = 'Raised Platform';

///it's 6 letters but 5th index??
const int kAspectStringSkip = 6;

const Color kCommonColorPrimaryDark = Color(0xff2A2B9F);
const String kFontFamily = 'Montserrat';
// const TextStyle kAspectTextStyle = TextStyle(
//   fontWeight: FontWeight.w600,
//   fontFamily: kFontFamily,
//   color: kCommonColorPrimaryDark,
//   fontSize: 20,
// );

class ErrorScreen extends StatelessWidget {
  const ErrorScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Text(
        'OOPS',
        style: TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }
}
