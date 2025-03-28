import 'package:flutter/material.dart';

class Scroller extends StatelessWidget {
  final Axis direction;
  final int amount;
  final List<Widget> children;
  final EdgeInsets? margin;
  const Scroller({
    super.key,
    required this.direction,
    required this.amount,
    required this.children,
    this.margin = const EdgeInsets.all(0)
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin!, 
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
      scrollDirection: direction,
      child: Row(
        spacing: 16,
        children: children
      )
      )
    );
  }
}