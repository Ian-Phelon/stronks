import 'package:flutter/material.dart';
import '../../constants.dart';

String _title(String key) {
  bool isTargets = key.startsWith(r'target');
  bool isEquips = key.startsWith(r'equips');
  String fromKey = key.characters.skip(kAspectStringSkip).toString();
  if (isTargets) fromKey = fromKey.substring(0, fromKey.characters.length - 5);
  if (isEquips) {
    switch (key) {
      case kEquipsMachineCardio:
        fromKey = kEquipsMachineCardioToText;
        break;
      case kEquipsMachineStrength:
        fromKey = kEquipsMachineStrengthToText;
        break;
      case kEquipsRaisedPlatform:
        fromKey = kEquipsRaisedPlatformToText;
        break;
      case kEquipsPullupBar:
        fromKey = kEquipsPullupBarToText;
        break;
      default:
        fromKey = fromKey;
    }
  }

  return fromKey;
}

class AspectTile extends StatelessWidget {
  const AspectTile({
    Key? key,
    required this.aspect,
    required this.tapForSelection,
    required this.isSelected,
    this.mapTargetFine,
    this.height,
    this.width,
    this.updateInner,
    this.updateOuter,
    this.updateUpper,
    this.updateLower,
  }) : super(key: key);

  final Map<String, bool>? mapTargetFine;
  final MapEntry aspect;
  final VoidCallback tapForSelection;

  final VoidCallback? updateInner;
  final VoidCallback? updateOuter;
  final VoidCallback? updateUpper;
  final VoidCallback? updateLower;

  final Size? height;
  final Size? width;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final String key = aspect.key;
    late Map<String, bool> targetFine;
    if (mapTargetFine == null || mapTargetFine!.isEmpty) {
      targetFine = {};
    } else {
      targetFine = mapTargetFine!;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 12,
          right: isSelected
              ? 12
              : mapTargetFine == null
                  ? 12
                  : null,
          child: Container(
            margin: EdgeInsets.all(2.0),
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  width: 4,
                  color: Colors.black,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 28,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                        child: Text(
                          _title(key),
                          style: kAspectTextStyle,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSelected && mapTargetFine != null,
                      replacement: const SizedBox.shrink(),
                      child: targetFine.isEmpty
                          ? const SizedBox.shrink()
                          : _targetIconRow(
                              targetFine: targetFine,
                              inner: updateInner!,
                              outer: updateOuter!,
                              upper: updateUpper!,
                              lower: updateLower!,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: tapForSelection,
            child: Material(
              shape: CircleBorder(
                side: BorderSide(
                  width: 6,
                  color: Colors.black,
                ),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Icon(
                  Icons.check,
                  color: isSelected ? Colors.green : Colors.black,
                  size: 29,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _targetIcon({
  required IconData iconData,
  required MapEntry<String, bool> target,
  required Function() targetFineSelect,
}) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Opacity(
        opacity: target.value ? 1 : 0.5,
        child: GestureDetector(
          onTap: targetFineSelect,
          child: Icon(
            iconData,
            color: target.value ? Colors.green : Colors.black,
          ),
        )),
  );
}

Widget _targetIconRow({
  required Map<String, bool> targetFine,
  required Function() inner,
  required Function() outer,
  required Function() upper,
  required Function() lower,
}) {
  // MapEntry<String, bool> e1 = targetFine.entries.elementAt(0);
  // MapEntry<String, bool> e2 = targetFine.entries.elementAt(1);
  // MapEntry<String, bool> e3 = targetFine.entries.elementAt(2);
  // MapEntry<String, bool> e4 = targetFine.entries.elementAt(3);
  Widget iconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _targetIcon(
          iconData: Icons.gps_fixed,
          target: targetFine.entries.elementAt(0),
          targetFineSelect: inner,
        ),
        _targetIcon(
          iconData: Icons.all_out,
          target: targetFine.entries.elementAt(1),
          targetFineSelect: outer,
        ),
        _targetIcon(
          iconData: Icons.keyboard_arrow_up,
          target: targetFine.entries.elementAt(2),
          targetFineSelect: upper,
        ),
        _targetIcon(
          iconData: Icons.keyboard_arrow_down,
          target: targetFine.entries.elementAt(3),
          targetFineSelect: lower,
        ),
      ],
    );
  }

  return targetFine.isEmpty ? const SizedBox.shrink() : iconRow();
}

// class SliverTilePiece extends SingleChildRenderObjectWidget {
//   SliverTilePiece({Key? key, Widget? child}) : super(key: key, child: child);
//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return SliverTilePieceRender();
//   }
// }

// class SliverTilePieceRender extends RenderSliverSingleBoxAdapter {
//   SliverTilePieceRender({
//     RenderBox? child,
//   }) : super(child: child);
//   @override
//   void performLayout() {
//     if (child == null) {
//       geometry = SliverGeometry.zero;
//       return;
//     }
//     final SliverConstraints constraints = this.constraints;
//     child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
//     final double childExtent;
//     switch (constraints.axis) {
//       case Axis.horizontal:
//         childExtent = child!.size.width;
//         break;
//       case Axis.vertical:
//         childExtent = child!.size.height;
//         break;
//     }
//     final double paintedChildSize =
//         calculatePaintOffset(constraints, from: 0.0, to: childExtent);
//     final double cacheExtent =
//         calculateCacheOffset(constraints, from: 0.0, to: childExtent);

//     assert(paintedChildSize.isFinite);
//     assert(paintedChildSize >= 0.0);
//     geometry = SliverGeometry(
//       scrollExtent: childExtent,
//       paintExtent: paintedChildSize,
//       cacheExtent: cacheExtent,
//       maxPaintExtent: childExtent,
//       hitTestExtent: paintedChildSize,
//       hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
//           constraints.scrollOffset > 0.0,
//     );
//     setChildParentData(child!, constraints, geometry!);
//   }
// }
