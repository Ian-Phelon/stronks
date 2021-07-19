import 'package:flutter/material.dart';
import 'dart:ui' show VoidCallback;

typedef Type Name(params);

/// a circle button
class RoundIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onTap;
  final double? size;
  final double? elevation;
  final int? countAmount;
  final String? text;

  const RoundIconButton({
    Key? key,
    required this.onTap,
    this.icon,
    this.size,
    this.elevation,
    this.countAmount,
    this.text,
  }) : super(key: key);

  double _size({
    IconData? icon,
  }) {
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
          height: size != null ? size! : _size(),
          width: size != null ? size! : _size(),
          child: Material(
            shadowColor: Theme.of(context).colorScheme.primary,
            elevation: elevation ?? 0,
            color: Theme.of(context).colorScheme.surface,
            shape: CircleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.onSurface,
                width: 6.0,
              ),
            ),
            child: icon == null
                ? Center(
                    child: Text(
                      '${text ?? countAmount}',
                      style: Theme.of(context).textTheme.headline6,
                      softWrap: false,
                    ),
                  )
                : Center(
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: size ?? _size(icon: icon) - 8.0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class StronksTextButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final Size? size;
  final double? elevation;
  final bool? isSelected;

  const StronksTextButton({
    Key? key,
    required this.onTap,
    this.text,
    this.isSelected,
    this.size,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getIsSelectedColor() {
      bool value;
      if (isSelected == null)
        value = false;
      else {
        value = isSelected!;
      }
      return value
          ? Theme.of(context).colorScheme.primaryVariant
          : Theme.of(context).colorScheme.primary;
    }

    return GestureDetector(
      child: Container(
        height: size?.height ?? MediaQuery.of(context).size.height * 0.069,
        width: size?.width ?? MediaQuery.of(context).size.width * 0.40,
        child: Material(
          elevation: elevation ?? 0,
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
            side: BorderSide(
              color: getIsSelectedColor(),
              width: 6.0,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                '$text',
                style: Theme.of(context).textTheme.headline6,
                // softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
