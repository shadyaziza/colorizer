import 'package:flutter/material.dart';

class IdentityColorFiltered extends StatelessWidget {
  const IdentityColorFiltered({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  final ColorFilter identity = const ColorFilter.matrix(<double>[
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: identity,
      child: child,
    );
  }
}

class GreyscaleColorFiltered extends StatelessWidget {
  const GreyscaleColorFiltered({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final ColorFilter greyscale = const ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: greyscale,
    );
  }
}
