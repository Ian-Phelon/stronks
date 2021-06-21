import 'package:flutter/material.dart';

import '../../constants.dart';
// import 'package:flutter/rendering.dart';

// Size _size(BuildContext context, String text) {
//   text += '_____';
//   return (TextPainter(
//           text: TextSpan(text: text, style: kAspectTextStyle),
//           maxLines: 1,
//           textScaleFactor: MediaQuery.of(context).textScaleFactor,
//           textDirection: TextDirection.ltr)
//         ..layout())
//       .size;
// }

// class AspectTileBuilder extends StatelessWidget {
//   const AspectTileBuilder(
//       {Key? key,
//       this.context,
//       required this.whichAspect,
//       required this.stringsForSizing,
//       required this.tapForSelection})
//       : super(key: key);
//   final BuildContext? context;
//   final Map<String, bool> whichAspect;
//   final List<String> stringsForSizing;
//   final VoidCallback tapForSelection;

//   @override
//   Widget build(BuildContext context) {
//     double textHeight(int index) =>
//         _size(context, stringsForSizing[index]).height;
//     double textWidth(int index) =>
//         _size(context, stringsForSizing[index]).width;

//     return ListView.builder(
//       // addAutomaticKeepAlives: true,

//       itemCount: whichAspect.length,
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//         bool isSelected = whichAspect.entries.elementAt(index).value;
//         /////////
//         return Container(
//           height: textHeight(index),
//           width: textWidth(index),
//           //Provider.of<ExerciseRepository>(context).syleKeys[index],

//           child: AspectTile(
//             // context: context,
//             isSelected: isSelected,
//             aspect: whichAspect.entries.elementAt(index),
//             tapForSelection: tapForSelection,
//           ),
//         );
//       },
//     );
//   }
// }

String _title(String key) {
  return key.characters.skip(kAspectStringSkip).toString();
}

class AspectTile extends StatelessWidget {
  const AspectTile({
    Key? key,
    // required this.buildContext,
    required this.aspect,
    required this.tapForSelection,
    required this.isSelected,
    this.mapTargetFine,
  }) : super(key: key);
  // final BuildContext buildContext;

  final Map<String, bool>? mapTargetFine;
  final MapEntry aspect;
  final VoidCallback tapForSelection;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final String key = aspect.key;

    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////
    /////////////////////////

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
                      child: Text(
                        _title(key),
                        style: kAspectTextStyle,
                      ),
                    ),
                    Visibility(
                      visible: isSelected && mapTargetFine != null,
                      replacement: const SizedBox.shrink(),

                      /// THIS IS DEPENDENT UPON Aspect.value
                      /// if it's targets, we need a row of target icons.
                      child: Text('BOO'),
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
            // onTap: () {
            //   _triggerSelection();
            // },
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

Widget _targetIcon({required IconData iconData, required bool isSelected}) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Opacity(
        opacity: isSelected ? 1 : 0.5,
        child: GestureDetector(
          child: Icon(
            iconData,
            color: isSelected ? Colors.green : Colors.black,
          ),
        )),
  );
}

Widget _targetIconRow(Map<String, bool> isSelected) {
  bool inner =
      isSelected.entries.firstWhere((e) => e.key.contains(r'*Inner')).value;
  bool outer =
      isSelected.entries.firstWhere((e) => e.key.contains(r'*Outer')).value;
  bool upper =
      isSelected.entries.firstWhere((e) => e.key.contains(r'*Upper')).value;
  bool lower =
      isSelected.entries.firstWhere((e) => e.key.contains(r'*Lower')).value;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _targetIcon(
        iconData: Icons.gps_fixed,
        isSelected: inner,
      ),
      _targetIcon(
        iconData: Icons.all_out,
        isSelected: outer,
      ),
      _targetIcon(
        iconData: Icons.keyboard_arrow_up,
        isSelected: upper,
      ),
      _targetIcon(
        iconData: Icons.keyboard_arrow_down,
        isSelected: lower,
      ),
    ],
  );
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
