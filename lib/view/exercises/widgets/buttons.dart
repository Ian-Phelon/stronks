import 'package:flutter/material.dart';
import 'dart:ui' show VoidCallback;

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
  final VoidCallback? onPressed;
  final Function? onPressedFunction;
  final double? size;
  final double? elevation;
  //final Color color;

  const RoundIconButton(
      {Key? key,
      @required this.icon,
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
      child: Icon(
        icon,
        size: size,
      ),
      padding: const EdgeInsets.all(8.0),
      onPressed: onPressed,
      shape: CircleBorder(),
      fillColor: Colors.blueGrey,
      elevation: elevation!,
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
