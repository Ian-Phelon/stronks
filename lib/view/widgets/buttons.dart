import 'package:flutter/material.dart';
import 'dart:ui' show VoidCallback;

import '../../constants.dart';

class SquareButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonText;
  final Color? color;

  const SquareButton({
    Key? key,
    @required this.onPressed,
    @required this.buttonText,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonText!),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          color,
        ),
        elevation: MaterialStateProperty.all(2.0),
      ),
    );
  }
}

/// a circle button
class RoundIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onTap;
  final double? size;
  final double? elevation;
  final int? countAmount;

  const RoundIconButton({
    Key? key,
    required this.onTap,
    this.icon,
    this.size,
    this.elevation,
    this.countAmount,
  }) : super(key: key);

  double _size({IconData? icon}) {
    double diameter;
    diameter = size ?? 50.0;
    double? i;
    if (icon != null && icon == Icons.edit) i = 40.0;

    return i ?? diameter;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: _size() == 50.0 && size != null ? size! : _size(),
          width: _size() == 50.0 && size != null ? size! : _size(),
          child: Material(
            elevation: elevation ?? 0,
            color: Theme.of(context).colorScheme.surface,
            shape: CircleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.onSurface,
                width: 8.0,
              ),
            ),
            child: icon == null
                ? Center(
                    child: Text(
                      '$countAmount',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                : Center(
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: size ?? _size(icon: icon) - 8.0,
                    ),
                  ),
            // ? Center(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: icon == null
            //           ? Text(

            //             )

            //       // ],
            //       // ),
            //     ),
            //   )
            // : Icon(
            //     icon,
            //     size: _size(icon: icon),
            //     color: Theme.of(context).colorScheme.onSurface,
            //   ),
          ),
        ),
      ),
    );
  }
}

class RoundTextButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Function? onPressedFunction;
  final double? size;
  final double? elevation;
  //final Color color;

  const RoundTextButton(
      {Key? key,
      @required this.text,
      @required this.onPressed,
      @required this.size,
      @required this.elevation,
      this.onPressedFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(
        minHeight: size!,
        minWidth: size!,
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Text('$text'),
      ),
      padding: const EdgeInsets.all(8.0),
      onPressed: onPressed,
      shape: CircleBorder(),
      fillColor: Colors.blueGrey,
      elevation: elevation!,
    );
  }
}
