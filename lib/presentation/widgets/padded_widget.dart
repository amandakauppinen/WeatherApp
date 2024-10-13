import 'package:flutter/material.dart';

enum PaddingSide { left, right, bottom, top }

/// Provides padding for a [child] widget depending on a given side(s)
class PaddedWidget extends StatelessWidget {
  final Widget child;
  final double left, right, top, bottom;

  const PaddedWidget(this.child,
      {super.key, this.left = 0, this.right = 0, this.top = 0, this.bottom = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom), child: child);
  }
}

class AllPaddedWidget extends PaddedWidget {
  final double padding;

  const AllPaddedWidget(super.child, this.padding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(padding), child: child);
  }
}

class HorizontalPaddedWidget extends PaddedWidget {
  final double padding;

  const HorizontalPaddedWidget(super.child, this.padding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: padding), child: child);
  }
}

class VerticalPaddedWidget extends PaddedWidget {
  final double padding;

  const VerticalPaddedWidget(super.child, this.padding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: padding), child: child);
  }
}
