import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

class AspectTile extends StatefulWidget {
  const AspectTile({
    Key? key,
    required this.buildContext,
    required this.title,
    required this.isSelected,
    this.isTargets,
  }) : super(key: key);
  final BuildContext buildContext;
  final String title;
  final Map<String, bool>? isTargets;
  final bool isSelected;

  @override
  _AspectTileState createState() => _AspectTileState();
}

class _AspectTileState extends State<AspectTile> {
  late bool isSelected;

  void _triggerSelection() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isSelected = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 12,
            right: isSelected
                ? 12
                : widget.isTargets == null
                    ? 12
                    : null,
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
                      width: 33,
                    ),
                    Text(
                      '${widget.title}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Visibility(
                      visible: isSelected && widget.isTargets != null,
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
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                _triggerSelection();
              },
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
      ),
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
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _targetIcon(
        iconData: Icons.gps_fixed,
        isSelected: true,
      ),
      _targetIcon(
        iconData: Icons.all_out,
        isSelected: true,
      ),
      _targetIcon(
        iconData: Icons.keyboard_arrow_up,
        isSelected: true,
      ),
      _targetIcon(
        iconData: Icons.keyboard_arrow_down,
        isSelected: true,
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
